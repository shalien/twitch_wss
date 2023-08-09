import 'package:twitch_wss/src/twitch_client.dart';

void main() async {
  TwitchClient client = await TwitchClient.create('nick', 'token');

  await for (var data in client) {
    print(data);
  }
}
