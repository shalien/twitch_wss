import 'package:meta/meta.dart';

import '../const/twitch_commands.dart';

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

  const RoomStateMessage(
      {required this.roomId,
      this.emoteOnly,
      this.followersOnly,
      this.r9k,
      this.slow,
      this.subsOnly,
      required super.channel})
      : super(command: roomState, content: null);

  factory RoomStateMessage.fromMap(
      {required String? channel, required Map<String, dynamic> map}) {
    return RoomStateMessage(
      roomId: map['room-id'],
      emoteOnly: map['emote-only'],
      followersOnly: map['followers-only'],
      r9k: map['r9k'],
      slow: map['slow'],
      subsOnly: map['subs-only'],
      channel: channel,
    );
  }
}
