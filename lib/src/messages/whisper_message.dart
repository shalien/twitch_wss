import '../base/messages/emote_message.dart';
import '../base/user/message_user.dart';
import '../const/twitch_commands.dart';
import '../twitch_client.dart';

import '../base/emote.dart';
import '../base/user/user.dart';

final class WhisperMessage extends EmoteMessage {
  /// An ID that uniquely identifies the whisper message.
  final String messageId;

  /// An ID that uniquely identifies the whisper message.
  final String threadId;

  WhisperMessage._(
      {required this.messageId,
      required this.threadId,
      required super.emotes,
      required super.channel,
      required super.content,
      required super.user})
      : super(command: whisper);

  factory WhisperMessage(TwitchClient client, Map<String, dynamic> map) {
    User user = MessageUser.fromMap(client, map);

    List<Emote> emotes = map['emotes'] == null
        ? <Emote>[]
        : (map['emotes'] as String)
            .split(',')
            .map((e) => Emote.fromRawString(e))
            .toList();

    return WhisperMessage._(
        messageId: map['message_id'],
        threadId: map['thread_id'],
        emotes: emotes,
        channel: map['recipient']['username'],
        content: map['body'],
        user: user);
  }
}
