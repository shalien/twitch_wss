import 'dart:convert';

import 'package:meta/meta.dart';

@immutable
final class TwitchSource {
  final String? nick;
  final String host;

  const TwitchSource._(this.nick, this.host);

  factory TwitchSource.parse(String source) {
    List<String> parts = source.split('!');

    if (parts.length == 1) {
      return TwitchSource._(null, parts.first);
    }

    return TwitchSource._(parts.first, parts.last);
  }

  String toJson() {
    return jsonEncode({
      'nick': nick,
      'host': host,
    });
  }
}
