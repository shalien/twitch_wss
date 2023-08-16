import 'package:meta/meta.dart';
import '../raw/irc_message.dart';

import '../base/messages/message.dart';

/// The Twitch IRC server sends this message after a bot joins a channel or when the channel’s chat room settings change.
/// For JOIN messages, the message contains all chat room setting tags, but for actions that change a single chat room setting, the message includes only that chat room setting tag.
/// For example, if the moderator turned on unique chat, the message includes only the r9k tag.
@immutable
final class RoomStateMessage extends Message {
  /// A Boolean value that determines whether the chat room allows only messages with emotes.
  final bool? emoteOnly;

  /// An integer value that determines whether only followers can post messages in the chat room.
  ///  The value indicates how long, in minutes, the user must have followed the broadcaster before posting chat messages.
  /// If the value is -1, the chat room is not restricted to followers only.
  final int? followersOnly;

  /// A Boolean value that determines whether a user’s messages must be unique.
  /// Applies only to messages with more than 9 characters
  final bool? r9k;

  /// An ID that identifies the chat room (channel).
  final int roomId;

  /// An integer value that determines how long, in seconds, users must wait between sending messages.
  final int? slow;

  /// 	A Boolean value that determines whether only subscribers and moderators can chat in the chat room
  final bool? subsOnly;

  /// The Twitch IRC server sends this message after a bot joins a channel or when the channel’s chat room settings change.
  /// For JOIN messages, the message contains all chat room setting tags, but for actions that change a single chat room setting, the message includes only that chat room setting tag.
  /// For example, if the moderator turned on unique chat, the message includes only the r9k tag.
  RoomStateMessage.parseIRC(IRCMessage ircMessage)
      : emoteOnly = ircMessage.tags['emote-only'] == '1',
        followersOnly = int.tryParse(ircMessage.tags['followers-only'] ?? ''),
        r9k = ircMessage.tags['r9k'] == '1',
        roomId = int.tryParse(ircMessage.tags['room-id'] ?? '') ?? 0,
        slow = int.tryParse(ircMessage.tags['slow'] ?? ''),
        subsOnly = ircMessage.tags['subs-only'] == '1',
        super.parseIRC(ircMessage);
}
