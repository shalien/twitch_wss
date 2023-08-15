import 'package:meta/meta.dart';
import 'package:tmi_dart/src/base/messages/message.dart';

@immutable
@internal
abstract base class TimestampMessage extends Message {
  /// The UNIX timestamp.
  final int tmiSentTs;

  const TimestampMessage(
      {required this.tmiSentTs,
      required super.command,
      required super.channel,
      required super.content});
}
