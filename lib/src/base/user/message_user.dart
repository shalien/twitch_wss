import 'package:tmi_dart/tmi_dart.dart';

import '../badge.dart';
import 'user.dart';

final class MessageUser extends User {
  /// The amount of Bits the user cheered.
  /// Only a Bits cheer message includes this .
  /// To learn more about Bits, see the Extensions Monetization Guide.
  final int? bits;

  /// A Boolean value that determines whether the user is a moderator.
  /// Is true (1) if the user is a moderator; otherwise, false (0)
  final int? _mod;

  /// A Boolean value that determines whether the user is a moderator.
  bool get isMod => _mod == 1;

  /// A Boolean value that determines whether the user is a subscriber.
  /// Is true (1) if the user is a subscriber; otherwise, false (0).
  final int? _subscriber;

  /// A Boolean value that determines whether the user is a subscriber.
  bool get isSubscriber => _subscriber == 1;

  /// A Boolean value that determines whether the user is a VIP.
  /// Is true (1) if the user is a VIP; otherwise, false (0).
  final int? _vip;

  /// A Boolean value that determines whether the user is a VIP.
  bool get isVip => _vip == 1;

  MessageUser._(super.client, super.turbo, super.badges, super.badgeInfo,
      super.emoteSets, this.bits, this._mod, this._subscriber, this._vip,
      {required super.color,
      required super.displayName,
      required super.userId,
      required super.userType});

  factory MessageUser.fromMap(TwitchClient client, Map<String, dynamic> map) {
    String color = map['color'];
    String displayName = map['display-name'];
    int turbo = map['turbo'];
    int userId = map['user-id'];
    String userType = map['user-type'];

    // Extract badge-info from badge-info string
    Map<String, String> badgeInfo = {};
    if (map.containsKey('badge-info')) {
      List<String> badgeInfoList = map['badge-info'].split(',');
      for (String badge in badgeInfoList) {
        List<String> badgeParts = badge.split('/');
        badgeInfo[badgeParts[0]] = badgeParts[1];
      }
    }

    // Extract badges from badges string
    Set<Badge> badges = {};

    if (map.containsKey('badges')) {
      List<String> badgeList = map['badges'].split(',');
      for (String badge in badgeList) {
        List<String> badgeParts = badge.split('/');
        badges
            .add(Badge(name: badgeParts[0], version: int.parse(badgeParts[1])));
      }
    }

    // Extract emotes from emotes string
    Set<String> emoteSets = {};

    if (map.containsKey('emote-sets')) {
      emoteSets.addAll(map['emote-sets'].map((e) => e.trim()).split(','));
    }

    return MessageUser._(client, turbo, badges, badgeInfo, emoteSets,
        map['bits'], map['mod'], map['subscriber'], map['vip'],
        color: color,
        displayName: displayName,
        userId: userId,
        userType: userType);
  }
}
