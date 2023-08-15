import '../tag.dart';

final class ClearmsgMessageTag extends Tag {
  final String login;
  final int? roomId;
  final String targetMsgId;
  final int tmiSentTs;
  final DateTime timestamp;

  ClearmsgMessageTag._({
    required this.login,
    required this.roomId,
    required this.targetMsgId,
    required this.tmiSentTs,
    required this.timestamp,
  });

  factory ClearmsgMessageTag.fromMap(Map rawTags) {
    return ClearmsgMessageTag._(
      login: rawTags['login'],
      roomId: rawTags['room-id'] == null ? null : int.parse(rawTags['room-id']),
      targetMsgId: rawTags['target-msg-id'],
      tmiSentTs: int.parse(rawTags['tmi-sent-ts']),
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        int.parse(rawTags['tmi-sent-ts']),
      ),
    );
  }
}
