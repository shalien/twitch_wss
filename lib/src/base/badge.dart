import 'package:meta/meta.dart';

///
/// Represents a Twitch badge.
///
@immutable
final class Badge {
  /// The name of the badge.
  final String name;

  /// The value of the badge.
  final int? version;

  /// Create a new Twitch badge.
  const Badge({required this.name, required this.version});

  /// Create a new Twitch badge from a raw string.
  factory Badge.fromRaw(String raw) {
    final parts = raw.split('/');
    return Badge(name: parts[0], version: int.tryParse(parts[1]));
  }
}
