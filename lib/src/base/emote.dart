import 'package:meta/meta.dart';

@immutable
final class Emote {
  /// The ID of the emote.
  final String id;

  /// The start index of the emote.
  final int start;

  /// The end index of the emote.
  final int? end;

  const Emote(this.id, this.start, this.end);

  factory Emote.fromRawString(String raw) {
    final parts = raw.split(':');
    final positions = parts[1].split('-');
    return Emote(parts[0], int.parse(positions.first),
        positions.last == '' ? null : int.parse(positions.last));
  }
}
