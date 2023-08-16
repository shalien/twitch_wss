import 'package:tmi_dart/src/raw/irc_message.dart';

import '../base/messages/message.dart';

/// The Twitch IRC server sends this message after the bot joins a channel or sends a [PrivMessage] message.
final class UserStateMessage extends Message {
  /// 	If a [PrivMessage] was sent, an ID that uniquely identifies the message.
  final String id;

  /// The Twitch IRC server sends this message after the bot joins a channel or sends a [PrivMessage] message.
  @override
  UserStateMessage.parseIRC(IRCMessage ircMessage)
      : id = ircMessage.tags['id']!,
        super.parseIRC(ircMessage);
}
