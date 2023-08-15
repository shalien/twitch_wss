import 'package:meta/meta.dart';
import 'package:tmi_dart/src/base/messages/timestamp_message.dart';

import '../const/twitch_commands.dart';

/// The Twitch IRC server sends this message after the bot removes a single message from the chat room.
@immutable
final class ClearMessage extends TimestampMessage {
  /// 	The name of the user who sent the message.
  final String login;

  /// The ID of the channel (chat room) where the message was removed from.
  final int? roomId;

  /// A UUID that identifies the message that was removed
  final String targetMsgId;

  /// The Twitch IRC server sends this message after the bot removes a single message from the chat room.
  const ClearMessage._(
      {required this.login,
      required this.targetMsgId,
      required super.tmiSentTs,
      this.roomId,
      required super.channel,
      required super.content})
      : super(command: clearMsg);

  /// The Twitch IRC server sends this message after the bot removes a single message from the chat room.
  factory ClearMessage.fromMap(
      {String? channel, String? content, required Map<String, dynamic> map}) {
    return ClearMessage._(
      login: map['login'],
      targetMsgId: map['target-msg-id'],
      tmiSentTs: map['tmi-sent-ts'],
      roomId: map['room-id'],
      channel: channel,
      content: content,
    );
  }
}
