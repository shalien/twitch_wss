import 'dart:collection';

import '../base/messages/message.dart';
import '../mixin/has_emote.dart';
import '../raw/irc_message.dart';

import '../base/emote.dart';

final class WhisperMessage extends Message with hasEmote {
  /// An ID that uniquely identifies the whisper message.
  final String messageId;

  /// An ID that uniquely identifies the whisper message.
  final String threadId;

  final List<Emote> _emotes;

  /// The emotes that were used in this message.
  UnmodifiableListView get emotes => UnmodifiableListView(_emotes);

  /// The Twitch IRC server sends this message after someone sends your bot a whisper message
  WhisperMessage.parseIRC(IRCMessage ircMessage)
      : messageId = ircMessage.tags['message-id']!,
        threadId = ircMessage.tags['thread-id']!,
        _emotes = hasEmote.parseEmotes(ircMessage),
        super.parseIRC(ircMessage);
}
