import 'package:sha_env/sha_env.dart';
import 'package:twitch_wss/twitch_wss.dart';

void main() async {
  await load();

  final client = await TwitchClient.create(
      fromEnvironmentString('TWITCH_USERNAME'),
      fromEnvironmentString('TWITCH_TOKEN'));
  bool sent = false;

  client.listen((event) {
    if (!sent) {
      client.send('shalien', 'Ca faisait longtemps, non ? 🕒');
      sent = true;
    }

    print('${event.command} ${event.channel} ${event.author}: ${event.params}');
  }, onError: (error) {
    print(error);
  }, onDone: () {
    print('Done');
  });

  client.join('shalien');

  client.send('shalien', 'something');
}
