import '../raw/irc_message.dart';

import '../base/emote.dart';

/// A mixin that adds emote parsing to a class.
mixin hasEmote {
  /// Parses emotes from a message and returns an array of emote objects.
  static List<Emote> parseEmotes(IRCMessage ircMessage) {
    final emotes = <Emote>[];
    if (ircMessage.tags.containsKey('emotes')) {
      final emoteString = ircMessage.tags['emotes'] as String;
      final emoteList = emoteString.split(',');
      emotes.addAll(emoteList.map((e) => Emote.fromRawString(e)));
    }

    return emotes;
  }
}
