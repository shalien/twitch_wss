import 'package:meta/meta.dart';
import 'package:tmi_dart/src/base/messages/timestamp_message.dart';
import 'package:tmi_dart/src/raw/raw_message.dart';

import '../const/twitch_commands.dart';

@immutable
final class ClearChatMessage extends TimestampMessage {
  /// Duration of the ban in seconds
  final int? banDuration;

  /// Id of the channel where the messages were removed from
  final int roomId;

  /// The ID of the user that was banned or put in a timeout.
  /// The user was banned if [banDuration] is [null].
  final int? targetUserId;

  /// The name of the user that was banned or put in a timeout.
  String? get targerUserName => content;

  /// The Twitch IRC server sends this message after a bot or moderator removes all messages from the chat room or removes all messages for the specified user
  const ClearChatMessage._({
    required this.roomId,
    this.banDuration,
    this.targetUserId,
    required super.content,
    required super.channel,
    required super.tmiSentTs,
  }) : super(command: clearChat);

  factory ClearChatMessage.parseIRC(RawMessage rawMessage) {
    final tags = rawMessage.tags;
    final channel = rawMessage.channel;
    final content = rawMessage.params;

    return ClearChatMessage._(
        roomId: int.parse(tags!['room-id']!),
        tmiSentTs: int.parse(tags['tmi-sent-ts']!),
        banDuration: tags['ban-duration'] != null
            ? int.parse(tags['ban-duration']!)
            : null,
        targetUserId: tags['target-user-id'] != null
            ? int.parse(tags['target-user-id']!)
            : null,
        channel: channel,
        content: content);
  }

  /// The Twitch IRC server sends this message after a bot or moderator removes all messages from the chat room or removes all messages for the specified user
  factory ClearChatMessage.fromMap(
      {String? channel, String? content, required Map<String, dynamic> map}) {
    return ClearChatMessage._(
        roomId: int.parse(map['room-id']!),
        tmiSentTs: int.parse(map['tmi-sent-ts']!),
        banDuration: map['ban-duration'] != null
            ? int.parse(map['ban-duration']!)
            : null,
        targetUserId: map['target-user-id'] != null
            ? int.parse(map['target-user-id']!)
            : null,
        channel: channel,
        content: content);
  }
}
