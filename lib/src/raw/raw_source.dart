import 'package:meta/meta.dart';

@immutable
@internal
final class RawSource {
  final String? nick;
  final String host;

  const RawSource._(this.nick, this.host);

  factory RawSource.parse(String source) {
    List<String> parts = source.split('!');

    if (parts.length == 1) {
      return RawSource._(null, parts.first);
    }

    return RawSource._(parts.first, parts.last);
  }
}
