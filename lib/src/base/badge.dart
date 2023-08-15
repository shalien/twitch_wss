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
}
