///
/// Represents a Twitch badge.
///
@immutable
final class TwitchBadge {
  /// The name of the badge.
  final String name;

  /// The value of the badge.
  final int? value;

  /// Create a new Twitch badge.
  const TwitchBadge._(this.name, this.value);

  factory TwitchBadge.parse(String badge) {
    List<String> parts = badge.split('/');

    if (parts.length == 1) {
      return TwitchBadge._(parts.first, null);
    } else {
      return TwitchBadge._(parts.first, int.parse(parts.last));
    }
  }

  @override
  String toString() {
    return 'TwitchBadge{name: $name, value: $value}';
  }
}
