import 'package:test/test.dart';
import 'package:tmi_dart/src/raw_message.dart';

void main() async {
  test('Command Parsing', () async {
    const String source =
        '@badges=staff/1,broadcaster/1,turbo/1;color=#FF0000;display-name=PetsgomOO;emote-only=1;emotes=33:0-7;flags=0-7:A.6/P.6,25-36:A.1/I.2;id=c285c9ed-8b1b-4702-ae1c-c64d76cc74ef;mod=0;room-id=81046256;subscriber=0;turbo=0;tmi-sent-ts=1550868292494;user-id=81046256;user-type=staff :petsgomoo!petsgomoo@petsgomoo.tmi.twitch.tv PRIVMSG #petsgomoo :DansGame';

    RawMessage message = RawMessage.parse(source);

    print(message.toJson());
  });

  test('Bot Command', () async {
    const String source =
        ':lovingt3s!lovingt3s@lovingt3s.tmi.twitch.tv PRIVMSG #lovingt3s :!dilly';

    RawMessage message = RawMessage.parse(source);

    print(message.toJson());
  });

  test('PING Command', () async {
    const String source = 'PING :tmi.twitch.tv';

    RawMessage message = RawMessage.parse(source);

    print(message.toJson());
  });
}
