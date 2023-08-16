import 'package:test/test.dart';
import 'package:tmi_dart/src/messages/clear_chat_message.dart';
import 'package:tmi_dart/src/raw/irc_message.dart';

void main() async {
  group('Testing CLEARCHAT messages parsing', () {
    test('Dallas banned ronni and deleted his/her messages', () {
      const String rawMessageString =
          '@room-id=12345678;target-user-id=87654321;tmi-sent-ts=1642715756806 :tmi.twitch.tv CLEARCHAT #dallas :ronni';

      IRCMessage rawMessage = IRCMessage.parse(rawMessageString);

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

    test('Dallas deleted all message in the chat room', () {
      const String rawMessageString =
          '@room-id=12345678;tmi-sent-ts=1642715756806 :tmi.twitch.tv CLEARCHAT #dallas';

      IRCMessage rawMessage = IRCMessage.parse(rawMessageString);

      ClearChatMessage message = ClearChatMessage.parseIRC(rawMessage);

      expect([
        message.roomId,
        message.targetUserId,
        message.tmiSentTs,
        message.channel,
        message.content
      ], [
        12345678,
        null,
        1642715756806,
        '#dallas',
        null
      ]);
    });

    test(
        'Dallas put ronni in timeout and removed all of his/her messages from the chat room',
        () {
      const String rawMessageString =
          '@ban-duration=60;room-id=12345678;target-user-id=87654321;tmi-sent-ts=1642715756806 :tmi.twitch.tv CLEARCHAT #dallas :ronni';

      IRCMessage rawMessage = IRCMessage.parse(rawMessageString);

      ClearChatMessage message = ClearChatMessage.parseIRC(rawMessage);

      expect([
        message.banDuration,
        message.roomId,
        message.targetUserId,
        message.tmiSentTs,
        message.channel,
        message.content
      ], [
        60,
        12345678,
        87654321,
        1642715756806,
        '#dallas',
        'ronni'
      ]);
    });
  });
}
