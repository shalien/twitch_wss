import 'package:sha_env/sha_env.dart';
import 'package:tmi_dart/tmi_dart.dart';

void main() async {
  await load();

  final client = await TwitchClient.create(
      fromEnvironmentString('TWITCH_USERNAME'),
      fromEnvironmentString('TWITCH_TOKEN'),
      channels: ['shalien', 'roiours']);
  bool sent = false;

  // client.joinChannel(fromEnvironmentString('TWITCH_USERNAME'));

  await for (var message in client) {
    if (!sent) {}
  }

  print(client.user?.color);
}
