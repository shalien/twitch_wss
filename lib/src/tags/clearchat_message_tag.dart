import '../tag.dart';

final class ClearchatMessageTag extends Tag {
  final int? banDuration;
  final int roomId;
  final int? targetUserId;
  final int tmiSendTs;

  final DateTime timestamp;

  ClearchatMessageTag._({
    required this.banDuration,
    required this.roomId,
    required this.targetUserId,
    required this.tmiSendTs,
    required this.timestamp,
  });

  factory ClearchatMessageTag.fromMap(Map rawTags) {
    return ClearchatMessageTag._(
      banDuration: rawTags['ban-duration'] == null
          ? null
          : int.parse(rawTags['ban-duration']),
      roomId: int.parse(rawTags['room-id']),
      targetUserId: rawTags['target-user-id'] == null
          ? null
          : int.parse(rawTags['target-user-id']),
      tmiSendTs: int.parse(rawTags['tmi-sent-ts']),
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        int.parse(rawTags['tmi-sent-ts']),
      ),
    );
  }
}
