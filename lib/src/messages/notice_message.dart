import 'package:tmi_dart/src/const/twitch_commands.dart';

import '../base/messages/message.dart';

/// The Twitch IRC server sends this message to indicate the outcome of the action
final class NoticeMessage extends Message {
  /// An ID that you can use to programmatically determine the action’s outcome.
  /// For a list of possible IDs, see NOTICE Message IDs.
  final String msgId;

  /// The ID of the user that the action targeted.
  final int targetUserId;

  /// The Twitch IRC server sends this message to indicate the outcome of the action
  const NoticeMessage._(
      {required this.msgId,
      required this.targetUserId,
      required super.channel,
      required super.content})
      : super(command: notice);

  /// The Twitch IRC server sends this message to indicate the outcome of the action
  factory NoticeMessage.fromMap(
      {required String? channel,
      required String? content,
      required Map<String, dynamic> map}) {
    String msgId = map['msg-id'];
    int targetUserId = map['target-user-id'];

    return NoticeMessage._(
        msgId: msgId,
        targetUserId: targetUserId,
        channel: channel,
        content: content);
  }
}
