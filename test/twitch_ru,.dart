import 'package:twitch_wss/twitch_wss.dart';

void main() async {
  final client = await TwitchClient.create(
      'dickhead2', 'oauth:23my81iedcsmgz9rtvlgsw33ats141');

  client.add('JOIN #saltybet');

  await for (var message in client) {
    print('message: ${message.toJson()}');
  }
}
