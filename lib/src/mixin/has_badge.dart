import '../raw/irc_message.dart';

import '../base/badge.dart';

/// A mixin that adds the ability to parse badges from IRC messages.
mixin hasBadge {
  /// Parse the badges from the [ircMessage] and return them as a list.
  static Set<Badge> parseBadges(IRCMessage ircMessage) {
    final badges = <Badge>{};
    if (ircMessage.tags.containsKey('badges')) {
      Set<String> badgeList = ircMessage.tags['badges'].split(',');
      badges.addAll(badgeList.map((badge) => Badge.fromRaw(badge)));
    }
    return badges;
  }
}
