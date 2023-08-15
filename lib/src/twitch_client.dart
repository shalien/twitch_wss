import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'const/twitch_commands.dart';

import 'channel.dart';
import 'base/messages/message.dart';
import 'raw/raw_message.dart';
import 'base/user/user.dart';

const String _baseUrl = 'wss://irc-ws.chat.twitch.tv:443';

class TwitchClient extends Stream<Message> {
  /// Twitch Identity
  User? _user;

  User? get user => _user;

  final Map<String, User> _identities = {};

  /// Socket

  WebSocket _socket;

  final LineSplitter _splitter = LineSplitter();

  /// Stream control

  final StreamController<Message> _controller =
      StreamController<Message>.broadcast();

  Stream<Message> get _internalStream => _controller.stream;

  /// Bot auth

  final String nick;

  final String _token;

  /// Bot data

  final List<Channel> _channels = [];

  /// Startup channels
  final List<String> _startupChannels;

  UnmodifiableListView<Channel> get channels => UnmodifiableListView(_channels);

  TwitchClient._(this._socket, this.nick, this._token, {List<String>? channels})
      : _startupChannels = channels ?? const [];

  bool _isConnected = false;

  bool get isConnected => _isConnected;

  static Future<TwitchClient> create(String nick, String token,
      {List<String>? channels}) async {
    WebSocket socket;

    try {
      socket = await WebSocket.connect(_baseUrl);
    } catch (e) {
      rethrow;
    }

    TwitchClient instance =
        TwitchClient._(socket, nick, token, channels: channels);

    /// Will split messages on new lines
    instance._socket.transform(instance._splitter).listen(instance._handleData,
        onError: instance._handleError, onDone: instance._handleDone);

    /// Requesting additionnal capabilities
    instance._socket.addUtf8Text(utf8.encode(
        'CAP REQ :twitch.tv/commands twitch.tv/membership twitch.tv/tags'));

    /// Sending auth
    instance._socket.addUtf8Text(utf8.encode('PASS $token'));
    instance._socket.addUtf8Text(utf8.encode('NICK $nick'));

    return instance;
  }

  void _handleData(dynamic data) {
    String rawMessage = data is String ? data : utf8.decode(data);

    /// Skipping empty messages
    if (rawMessage.isEmpty) {
      return;
    }

    /// Doing a first parsing to separate tags, source, command and params
    var message = RawMessage.parse(rawMessage);

    /// Commands are always in uppercase so to avoid unnecessary transformations we are comparing uppercase values
    switch (message.command) {
      case globalUserState:
        User newUser = User.fromMap(this, message.tags);

        _user = newUser;
        break;
      case join:
        break;
      case notice:
        print(rawMessage);
        break;
      case part:
        break;
      case ping:
        _socket.addUtf8Text(utf8.encode('PONG :tmi.twitch.tv'));
        break;
      case privmsg:
        break;

      case threeFiveThree:
        break;
      case threeSevenSix:
        _isConnected = true;

        for (var channel in _startupChannels) {
          joinChannel(channel);
        }

        break;

      case zeroZeroOne:
      case zeroZeroTwo:
      case zeroZeroThree:
      case zeroZeroFour:
      case threeSevenFive:
      case threeSevenTwo:
        break;

      default:
        print('Unknown command ${message.command} :  $rawMessage');
        break;
    }
  }

  void _handleError(dynamic error) {
    _controller.addError(error);
  }

  void _handleDone() {
    _isConnected = false;
    _socket.close();
    _controller.close();
  }

  void close() {
    _isConnected = false;
    _socket.close();
    _controller.close();
  }

  void send(String channel, String message) {
    channel = channel.startsWith('#') ? channel : '#$channel';

    List<int> utf8Message = utf8.encode('PRIVMSG $channel :$message');

    _socket.addUtf8Text(utf8Message);
  }

  void sendWhisper(String displayName, String message) {
    List<int> utf8Message = utf8.encode('PRIVMSG #$displayName :$message');

    _socket.addUtf8Text(utf8Message);
  }

  void joinChannel(String channel) {
    channel = channel.startsWith('#') ? channel : '#$channel';

    _socket.addUtf8Text(utf8.encode('JOIN $channel'));
  }

  void partChannel(String channel) {
    Channel? newChannel =
        _channels.firstWhereOrNull((element) => element.name == channel);

    if (newChannel != null) {
      _channels.remove(newChannel);
      newChannel.partChannel();
    } else {
      _controller.addError('Not in channel #$channel');
    }
  }

  @override
  StreamSubscription<Message> listen(void Function(Message event)? onData,
      {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return _internalStream.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}
