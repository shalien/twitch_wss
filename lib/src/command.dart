import 'dart:convert';

import 'package:meta/meta.dart';

@immutable
final class Command {
  final String command;
  final String channel;
  final String? message;

  const Command._(this.command, this.channel, this.message);

  factory Command.parse(String raw) {
    List<String> parts = raw.split(' ');

    if (parts.length == 1) {
      return Command._(parts.first.trim(), '', null);
    } else if (parts.length == 2) {
      return Command._(parts.first.trim(), parts[1].trim(), null);
    } else {
      return Command._(parts.first.trim(), parts[1].trim(),
          parts.map((e) => e.trim()).toList().sublist(2).join(' '));
    }
  }

  String toJson() {
    return jsonEncode({
      'command': command,
      'channel': channel,
      'message': message,
    });
  }
}
