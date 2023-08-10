import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:twitch_wss/src/twitch_message.dart';

const String _baseUrl = 'wss://irc-ws.chat.twitch.tv:443';

class TwitchClient extends Stream<TwitchMessage> {
  static WebSocket? _socket;

  final StreamController<TwitchMessage> _controller =
      StreamController<TwitchMessage>.broadcast();

  Stream<TwitchMessage> get _internalStream => _controller.stream;

  final String nick;

  final String _token;

  TwitchClient._(this.nick, this._token);

  static Future<TwitchClient> create(String nick, String token,
      {List<String>? channels}) async {
    TwitchClient instance = TwitchClient._(nick, token);
    _socket = await WebSocket.connect(_baseUrl);

    _socket!.listen(instance._handleData,
        onError: instance._handleError, onDone: instance._handleDone);

    try {
      _socket!.addUtf8Text(utf8.encode('PASS $token'));
      _socket!.addUtf8Text(utf8.encode('NICK $nick'));
    } catch (e) {
      print(e);
    }

    return instance;
  }

  void _handleData(dynamic data) {
    String raw = data is String ? data : utf8.decode(data);

    if (raw.isEmpty) return;

    var message = TwitchMessage.parse(raw);

    _controller.add(message);
  }

  void _handleError(dynamic error) {
    _controller.addError(error);
  }

  void _handleDone() {
    if (_socket != null) {
      _socket!.close();
    }

    _controller.close();
  }

  void close() {
    _socket?.close();

    _controller.close();
  }

  void add(String message) {
    _socket?.addUtf8Text(utf8.encode(message));
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
