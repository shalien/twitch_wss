import 'package:meta/meta.dart';
import '../base/messages/message.dart';
import '../raw/irc_message.dart';

@immutable
final class ClearChatMessage extends Message {
  /// Duration of the ban in seconds
  final int? banDuration;

  /// Id of the channel where the messages were removed from
  final int roomId;

  /// The ID of the user that was banned or put in a timeout.
  /// The user was banned if [banDuration] is [null].
  final int? targetUserId;

  /// The time the message was sent, in Unix time.
  final int tmiSentTs;

  /// The name of the user that was banned or put in a timeout.
  String? get targerUserName => content;

  /// The Twitch IRC server sends this message after a bot or moderator removes all messages from the chat room or removes all messages for the specified user
  @override
  ClearChatMessage.parseIRC(IRCMessage ircMessage)
      : banDuration = ircMessage.tags['ban-duration'] != null
            ? int.parse(ircMessage.tags['ban-duration']!)
            : null,
        roomId = int.parse(ircMessage.tags['room-id']!),
        targetUserId = ircMessage.tags['target-user-id'] != null
            ? int.parse(ircMessage.tags['target-user-id']!)
            : null,
        tmiSentTs = int.parse(ircMessage.tags['tmi-sent-ts']!),
        super.parseIRC(ircMessage);
}
