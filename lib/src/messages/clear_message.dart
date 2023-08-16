import 'package:meta/meta.dart';
import '../raw/irc_message.dart';
import '../base/messages/message.dart';

/// The Twitch IRC server sends this message after the bot removes a single message from the chat room.
@immutable
final class ClearMessage extends Message {
  /// 	The name of the user who sent the message.
  final String login;

  /// The ID of the channel (chat room) where the message was removed from.
  final int? roomId;

  /// A UUID that identifies the message that was removed
  final String targetMsgId;

  /// The time the server received the message, in UNIX time format.
  final int tmiSentTs;

  @override
  ClearMessage.parseIRC(IRCMessage ircMessage)
      : login = ircMessage.tags['login']!,
        roomId = int.tryParse(ircMessage.tags['room-id'] ?? ''),
        targetMsgId = ircMessage.tags['target-msg-id']!,
        tmiSentTs = int.parse(ircMessage.tags['tmi-sent-ts']),
        super.parseIRC(ircMessage);
}
