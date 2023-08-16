import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import '../../mixin/has_badge.dart';
import '../../../tmi_dart.dart';

import '../badge.dart';

@immutable
base class User with hasBadge {
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

  /// A comma-delimited list of IDs that identify the emote sets that the user has access to.
  /// Is always set to at least zero (0). To access the emotes in the set, use the Get Emote Sets API.
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

  /// The type of user. Possible values are:
  /// "" — A normal user
  /// admin — A Twitch administrator
  /// global_mod — A global moderator
  /// staff — A Twitch employee
  final String userType;

  @override
  @internal
  User.parseIRC(client, tags)
      : _client = client,
        _turbo = int.parse(tags['turbo'] ?? '0'),
        _badges = hasBadge.parseBadges(tags['badges']),
        _badgeInfo = tags.containsKey('badge-info')
            ? Map.fromEntries(tags['badge-info']!
                .split(',')
                .map((e) => e.trim())
                .map((e) => e.split('/')))
            : {},
        _emoteSets = tags.containsKey('emote-sets')
            ? tags['emote-sets']!.split(',').map((e) => e.trim()).toSet()
            : null,
        color = tags['color'] ?? '',
        displayName = tags['display-name'] ?? '',
        userId = int.parse(tags['user-id'] ?? '0'),
        userType = tags['user-type'] ?? '',
        _mod = int.parse(tags['mod'] ?? '0'),
        _subscriber = int.parse(tags['subscriber'] ?? '0'),
        _vip = int.parse(tags['vip'] ?? '0'),
        bits = tags.containsKey('bits') ? int.parse(tags['bits']!) : null;
}
