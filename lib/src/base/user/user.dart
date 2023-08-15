import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:tmi_dart/tmi_dart.dart';

import '../badge.dart';

base class User {
  /// The [TwitchClient] that created this [User]
  final TwitchClient _client;

  /// Set of [Badge]s that this [User] has
  final Set<Badge> _badges;

  /// Set of [Badge]s that this [User] has
  UnmodifiableSetView get badges => UnmodifiableSetView(_badges);

  /// Contains metadata related to the chat [badges].
  /// Currently, this tag contains metadata only for subscriber badges, to indicate the number of months the user has been a subscriber.
  final Map<String, String> _badgeInfo;

  /// Contains metadata related to the chat [badges].
  /// Currently, this tag contains metadata only for subscriber badges, to indicate the number of months the user has been a subscriber.
  UnmodifiableMapView get badgeInfo => UnmodifiableMapView(_badgeInfo);

  /// The [color] of the user’s name in the chat room. T
  /// his is a hexadecimal RGB color code in the form, #<RGB>.
  /// May be empty if it is never set.
  final String color;

  /// The user’s display name, escaped as described in the IRCv3 spec.
  /// May be empty if it is never set
  final String displayName;

  final Set<String>? _emoteSets;

  UnmodifiableSetView<String>? get emoteSets =>
      _emoteSets == null ? null : UnmodifiableSetView<String>(_emoteSets!);

  /// A Boolean value that indicates whether the user has site-wide commercial free mode enabled.
  /// Is true (1) if enabled; otherwise, false (0).
  final int _turbo;

  /// A Boolean value that indicates whether the user has site-wide commercial free mode enabled.
  bool isTurbo() => _turbo == 1;

  /// The user’s ID.
  final int userId;

  /// The user’s ID.
  int get id => userId;

  final String userType;

  @internal
  const User(
      this._client, this._turbo, this._badges, this._badgeInfo, this._emoteSets,
      {required this.color,
      required this.displayName,
      required this.userId,
      required this.userType});

  factory User.fromMap(TwitchClient client, Map<String, dynamic> map) {
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

    return User(client, turbo, badges, badgeInfo, emoteSets,
        color: color,
        displayName: displayName,
        userId: userId,
        userType: userType);
  }

  void sendWhisper(String message) {
    _client.sendWhisper(displayName, message);
  }
}
