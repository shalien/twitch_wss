import 'package:test/test.dart';
import 'package:tmi_dart/src/messages/clear_chat_message.dart';
import 'package:tmi_dart/src/raw/raw_message.dart';

void main() async {
  group('Testing CLEARCHAT messages parsing', () {
    test('Dallas banned ronni and deleted his/her messages', () {
      const String rawMessageString =
          '@room-id=12345678;target-user-id=87654321;tmi-sent-ts=1642715756806 :tmi.twitch.tv CLEARCHAT #dallas :ronni';

      RawMessage rawMessage = RawMessage.parse(rawMessageString);

      ClearChatMessage message = ClearChatMessage.parseIRC(rawMessage);

      expect([
        message.roomId,
        message.targetUserId,
        message.tmiSentTs,
        message.channel,
        message.content
      ], [
        12345678,
        87654321,
        1642715756806,
        '#dallas',
        'ronni'
      ]);
    });
  });
}
