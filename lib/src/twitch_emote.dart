import 'package:meta/meta.dart';

///
/// Represent a Twitch emote with its id and its position in the message.
@immutable
final class TwitchEmote {
  /// The id of the emote.
  final int id;

  /// The start position of the emote in the message.
  final int startPosition;

  /// The end position of the emote in the message.
  final int endPosition;

  /// Create a new Twitch emote.
  const TwitchEmote._(this.id, this.startPosition, this.endPosition);

  factory TwitchEmote.parse(String emote) {
    List<String> parts = emote.split(':');

    List<String> positions = parts.last.split(',');

    return TwitchEmote._(
      int.parse(parts.first),
      int.parse(positions.first),
      int.parse(positions.last),
    );
  }

  @override
  String toString() {
    return 'TwitchEmote{id: $id, startPosition: $startPosition, endPosition: $endPosition}';
  }
}
