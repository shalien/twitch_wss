import 'package:meta/meta.dart';
import 'package:tmi_dart/src/twitch_client.dart';

import '../../raw/irc_message.dart';
import '../user/user.dart';

@immutable
abstract base class Message {
  /// The command that was used to trigger this message.
  final String command;

  /// The channel that this message was sent in.
  final String? channel;

  /// The content of the message.
  final String? content;

  /// The client that received this message.
  final TwitchClient client;

  /// The user that sent this message.
  final User? user;

  Message.parseIRC(IRCMessage message)
      : command = message.command,
        channel = message.channel,
        content = message.content,
        client = message.client,
        user = message.tags.containsKey('display-name')
            ? User.parseIRC(message.client, message.tags)
            : null;
}
