import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:twitch_wss/src/twitch_message.dart';

import 'twitch_command.dart';

const String _baseUrl = 'wss://irc-ws.chat.twitch.tv:443';

class TwitchClient extends Stream<TwitchMessage> {
  late WebSocket _socket;

  final StreamController<TwitchMessage> _controller =
      StreamController<TwitchMessage>.broadcast();

  Stream<TwitchMessage> get _internalStream => _controller.stream;

  final String nick;

  final String _token;

  final List<String> _channels = [];

  UnmodifiableListView<String> get channels => UnmodifiableListView(_channels);

  TwitchClient._(this.nick, this._token, {List<String>? channels}) {
    if (channels != null) {
      _channels.addAll(channels);
    }
  }

  bool _isConnected = false;

  bool get isConnected => _isConnected;

  static Future<TwitchClient> create(String nick, String token,
      {List<String>? channels}) async {
    TwitchClient instance = TwitchClient._(nick, token, channels: channels);
    instance._socket = await WebSocket.connect(_baseUrl);

    instance._socket.listen(instance._handleData,
        onError: instance._handleError, onDone: instance._handleDone);

    instance._socket.addUtf8Text(utf8.encode(
        'CAP REQ :twitch.tv/commands twitch.tv/membership twitch.tv/tags'));
    instance._socket.addUtf8Text(utf8.encode('PASS $token'));
    instance._socket.addUtf8Text(utf8.encode('NICK $nick'));

    return instance;
  }

  void _handleData(dynamic data) {
    File file = File('test.log');
    if (!file.existsSync()) {
      file.createSync();
    }

    String raw = data is String ? data : utf8.decode(data);

    List<String> rawMessages = raw.split('\r\n');

    for (var rawMessage in rawMessages) {
      file.writeAsStringSync('$rawMessage\r\n', mode: FileMode.append);

      if (rawMessage.isEmpty) {
        continue;
      }

      var message = TwitchMessage.parse(rawMessage);

      print(rawMessage);
      print(message.toJson());

      switch (message.command?.toLowerCase()) {
        case cap:
          break;
        case join:
          _controller.add(message);
          break;
        case notice:
          switch (message.msgId) {
            case 'msg_ratelimit':
              close();
              throw Exception('Rate limit exceeded');
          }

          print(message.msgId);

          if (message.params?.contains('Improperly formatted auth') ?? false) {
            _socket.close();

            throw Exception('Login authentication failed with user $nick');
          } else if (message.params?.contains('Login authentication failed') ??
              false) {
            _socket.close();

            throw Exception('Login authentication failed with user $nick');
          } else {
            print(rawMessage);
          }

          break;
        case part:
          break;
        case ping:
          _socket.addUtf8Text(utf8.encode('PONG :tmi.twitch.tv'));
          break;
        case privmsg:
          _controller.add(message);
          break;
        case threeSevenSix:
          _isConnected = true;

          for (var channel in _channels) {
            channel = channel.startsWith('#') ? channel : '#$channel';

            _socket.addUtf8Text(utf8.encode('JOIN $channel'));
          }

          _controller.add(message);
          break;

        default:
          _controller.add(message);
          break;
      }
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

  void quit(String channel) {
    channel = channel.startsWith('#') ? channel : '#$channel';

    _socket.addUtf8Text(utf8.encode('PART #$channel'));
  }

  @override
  StreamSubscription<TwitchMessage> listen(
      void Function(TwitchMessage event)? onData,
      {Function? onError,
      void Function()? onDone,
      bool? cancelOnError}) {
    return _internalStream.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}
