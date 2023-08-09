import 'package:twitch_wss/twitch_wss.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final client = TwitchClient();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () async {
      client.start();
    });
  });
}
