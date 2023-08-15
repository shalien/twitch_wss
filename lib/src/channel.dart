import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:tmi_dart/tmi_dart.dart';

@immutable
final class Channel {
  static final Map<String, Channel> _channels = <String, Channel>{};

  final TwitchClient _client;

  final String name;

  final Map<int, String> _users = const <int, String>{};

  UnmodifiableMapView<int, String> get users => UnmodifiableMapView(_users);

  const Channel._(this._client, this.name);

  factory Channel.create(TwitchClient client, String name) {
    if (name.isEmpty) {
      throw ArgumentError('Channel name cannot be empty.');
    }

    name = name.toLowerCase();
    name = name.startsWith('#') ? name : '#$name';

    if (_channels.containsKey(name)) {
      return _channels[name]!;
    } else {
      Channel channel = Channel._(client, name);
      _channels[name] = channel;
      return channel;
    }
  }

  void sendMessage(String message) {
    _client.send(name, message);
  }

  void joinChannel() {
    _client.joinChannel(name);
  }

  void partChannel() {
    _client.partChannel(name);
  }

  @override
  operator ==(dynamic other) {
    if (other is Channel) {
      return name == other.name;
    }

    return false;
  }

  @override
  int get hashCode => name.hashCode;
}
