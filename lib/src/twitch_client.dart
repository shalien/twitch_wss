import 'dart:async';
import 'dart:convert';
import 'dart:io';

const String _baseUrl = 'wss://irc-ws.chat.twitch.tv:443';

class TwitchClient implements Stream<dynamic>, StreamSink<dynamic> {
  static WebSocket? _socket;

  final String _nick;
  final String _token;

  TwitchClient._(this._nick, this._token);

  static Future<TwitchClient> create(String nick, String token) async {
    TwitchClient _instance = TwitchClient._(nick, token);
    _socket = await WebSocket.connect(_baseUrl);

    _socket!.addUtf8Text(utf8.encode('PASS ${_instance._token}\r\n'));
    _socket!.addUtf8Text(utf8.encode('NICK ${_instance._nick}\n\r'));

    return _instance;
  }

  @override
  Future<bool> any(bool Function(dynamic element) test) => _socket!.any(test);

  @override
  Stream asBroadcastStream(
          {void Function(StreamSubscription subscription)? onListen,
          void Function(StreamSubscription subscription)? onCancel}) =>
      _socket!.asBroadcastStream(onListen: onListen, onCancel: onCancel);

  @override
  Stream<E> asyncExpand<E>(Stream<E>? Function(dynamic event) convert) =>
      _socket!.asyncExpand(convert);

  @override
  Stream<E> asyncMap<E>(FutureOr<E> Function(dynamic event) convert) =>
      _socket!.asyncMap(convert);

  @override
  Stream<R> cast<R>() => _socket!.cast<R>();

  @override
  Future<bool> contains(Object? needle) => _socket!.contains(needle);

  @override
  Stream distinct([bool Function(dynamic previous, dynamic next)? equals]) =>
      _socket!.distinct(equals);

  @override
  Future<E> drain<E>([E? futureValue]) => _socket!.drain<E>(futureValue);

  @override
  Future<dynamic> elementAt(int index) => _socket!.elementAt(index);

  @override
  Future<bool> every(bool Function(dynamic element) test) =>
      _socket!.every(test);

  @override
  Stream<S> expand<S>(Iterable<S> Function(dynamic element) convert) =>
      _socket!.expand<S>(convert);

  @override
  Future get first => _socket!.first;

  @override
  Future firstWhere(bool Function(dynamic element) test,
          {Function()? orElse}) =>
      _socket!.firstWhere(test, orElse: orElse);
  @override
  Future<S> fold<S>(
          S initialValue, S Function(S previous, dynamic element) combine) =>
      _socket!.fold(initialValue, combine);

  @override
  Future<void> forEach(void Function(dynamic element) action) =>
      _socket!.forEach(action);

  @override
  Stream handleError(Function onError, {bool Function(dynamic error)? test}) =>
      _socket!.handleError(onError, test: test);

  @override
  bool get isBroadcast => _socket!.isBroadcast;

  @override
  Future<bool> get isEmpty => _socket!.isEmpty;

  @override
  Future<String> join([String separator = ""]) => _socket!.join(separator);

  @override
  Future get last => _socket!.last;

  @override
  Future lastWhere(bool Function(dynamic element) test, {Function()? orElse}) =>
      _socket!.lastWhere(test, orElse: orElse);

  @override
  Future<int> get length => _socket!.length;

  @override
  StreamSubscription listen(void Function(dynamic event)? onData,
          {Function? onError, void Function()? onDone, bool? cancelOnError}) =>
      _socket!.listen(onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);

  @override
  Stream<S> map<S>(S Function(dynamic event) convert) =>
      _socket!.map<S>(convert);

  @override
  Future pipe(StreamConsumer streamConsumer) => _socket!.pipe(streamConsumer);

  @override
  Future reduce(Function(dynamic previous, dynamic element) combine) =>
      _socket!.reduce(combine);

  @override
  Future get single => _socket!.single;

  @override
  Future singleWhere(bool Function(dynamic element) test,
          {Function()? orElse}) =>
      _socket!.singleWhere(test, orElse: orElse);

  @override
  Stream skip(int count) => _socket!.skip(count);

  @override
  Stream skipWhile(bool Function(dynamic element) test) =>
      _socket!.skipWhile(test);

  @override
  Stream take(int count) => _socket!.take(count);

  @override
  Stream takeWhile(bool Function(dynamic element) test) =>
      _socket!.takeWhile(test);

  @override
  Stream timeout(Duration timeLimit,
          {void Function(EventSink sink)? onTimeout}) =>
      _socket!.timeout(timeLimit, onTimeout: onTimeout);

  @override
  Future<List> toList() => _socket!.toList();

  @override
  Future<Set> toSet() => _socket!.toSet();

  @override
  Stream<S> transform<S>(StreamTransformer<dynamic, S> streamTransformer) =>
      _socket!.transform(streamTransformer);

  @override
  Stream where(bool Function(dynamic event) test) => _socket!.where(test);

  @override
  void add(event) => _socket!.add(event);

  @override
  void addError(Object error, [StackTrace? stackTrace]) =>
      _socket!.addError(error, stackTrace);

  @override
  Future addStream(Stream stream) => _socket!.addStream(stream);

  @override
  Future close() => _socket!.close();

  @override
  Future get done => _socket!.done;
}
