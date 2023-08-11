import 'package:twitch_wss/twitch_wss.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () async {
      final client = await TwitchClient.create(
          'dickhead2', 'oauth:23my81iedcsmgz9rtvlgsw33ats141');
    });
  });
}
