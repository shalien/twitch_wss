import 'package:tmi_dart/src/const/twitch_commands.dart';

import '../base/messages/emote_message.dart';
import '../base/user/message_user.dart';

import '../base/emote.dart';
import '../twitch_client.dart';

/// The Twitch IRC server sends this message after the following events occur:
/// A user subscribes to the channel, re-subscribes to the channel, or gifts a subscription to another user.
/// A broadcaster raids the channel. Raid is a Twitch feature that lets broadcasters send their viewers to another channel to help support and grow other members in the community.
/// A viewer milestone is celebrated such as a new viewer chatting for the first time. These celebrations are called rituals.
final class UserNoticeMessage extends EmoteMessage {
  /// The id of the message.
  final int id;

  /// The login name of the user whose action generated the message.
  final String login;

  /// The type of notice (not the ID). Possible values are:
  /// sub
  /// resub
  /// subgift
  /// submysterygift
  /// giftpaidupgrade
  /// rewardgift
  /// anongiftpaidupgrade
  /// raid
  /// unraid
  /// ritual
  /// bitsbadgetier
  final String msgId;

  /// Included only with sub and resub notices.
  /// The total number of months the user has subscribed.
  /// This is the same as [msgParamMonths] but sent for different types of user notices.
  final int? msgParamCumulativeMonths;

  /// Included only with raid notices.
  /// The display name of the broadcaster raiding this channel.
  final String? msgParamDisplayName;

  /// Included only with raid notices.
  /// The login name of the broadcaster raiding this channel.
  final String? msgParamLogin;

  /// Included only with subgift notices.
  /// The total number of months the user has subscribed.
  ///  This is the same as msg-param-cumulative-months but sent for different types of user notices.
  final int? msgParamMonths;

  /// Included only with anongiftpaidupgrade and giftpaidupgrade notices.
  /// The number of gifts the gifter has given during the promo indicated by msg-param-promo-name.
  final int? msgParamPromoGiftTotal;

  /// Included only with anongiftpaidupgrade and giftpaidupgrade notices.
  /// The subscriptions promo, if any, that is ongoing (for example, Subtember 2018).
  final String? msgParamPromoName;

  /// Included only with subgift notices.
  /// The display name of the subscription gift recipient.
  final String? msgParamRecipientDisplayName;

  /// 	Included only with subgift notices.
  /// The user ID of the subscription gift recipient.
  final int? msgParamRecipientId;

  /// Included only with subgift notices.
  /// The user ID of the subscription gift recipient.
  final String? msgParamRecipientUserName;

  /// Included only with giftpaidupgrade notices.
  /// The login name of the user who gifted the subscription.
  final String? msgParamSenderLogin;

  /// Include only with giftpaidupgrade notices.
  /// The display name of the user who gifted the subscription.
  final String? msgParamSenderName;

  /// Include only with giftpaidupgrade notices.
  /// The display name of the user who gifted the subscription.
  final bool? msgParamShouldShareStreak;

  /// Included only with sub and resub notices.
  /// The number of consecutive months the user has subscribed. This is zero (0) if msg-param-should-share-streak is 0.
  final int? msgParamStreakMonths;

  /// Included only with sub, resub and subgift notices.
  /// The type of subscription plan being used.
  /// Possible values are:
  /// Prime — Amazon Prime subscription
  /// 1000 — First level of paid subscription
  /// 2000 — Second level of paid subscription
  /// 3000 — Third level of paid subscription
  final String? msgParamSubPlan;

  /// Included only with sub, resub, and subgift notices.
  /// The display name of the subscription plan.
  /// This may be a default name or one created by the channel owner.
  final String? msgParamSubPlanName;

  /// Included only with raid notices.
  /// The number of viewers raiding this channel from the broadcaster’s channel.
  final int? msgParamViewerCount;

  /// Included only with ritual notices.
  /// The name of the ritual being celebrated. Possible values are: `new_chatter`.
  final String? msgParamRitualName;

  /// 	Included only with bitsbadgetier notices.
  /// The tier of the Bits badge the user just earned. For example, 100, 1000, or 10000.
  final int? msgParamThreshold;

  /// 	Included only with subgift notices.
  /// The number of months gifted as part of a single, multi-month gift.
  final int? msgParamGiftMonths;

  /// An ID that identifies the chat room (channel).
  final String roomId;

  /// The message Twitch shows in the chat room for this notice.
  final String systemMsg;

  /// The UNIX timestamp for when the Twitch IRC server received the message.
  final int tmiSentTs;

  /// The Twitch IRC server sends this message after the following events occur:
  /// A user subscribes to the channel, re-subscribes to the channel, or gifts a subscription to another user.
  /// A broadcaster raids the channel. Raid is a Twitch feature that lets broadcasters send their viewers to another channel to help support and grow other members in the community.
  /// A viewer milestone is celebrated such as a new viewer chatting for the first time. These celebrations are called rituals.
  const UserNoticeMessage._({
    required super.channel,
    required super.content,
    required super.emotes,
    this.id = 0,
    this.login = '',
    this.msgId = '',
    this.msgParamCumulativeMonths,
    this.msgParamDisplayName,
    this.msgParamLogin,
    this.msgParamMonths,
    this.msgParamPromoGiftTotal,
    this.msgParamPromoName,
    this.msgParamRecipientDisplayName,
    this.msgParamRecipientId,
    this.msgParamRecipientUserName,
    this.msgParamSenderLogin,
    this.msgParamSenderName,
    this.msgParamShouldShareStreak,
    this.msgParamStreakMonths,
    this.msgParamSubPlan,
    this.msgParamSubPlanName,
    this.msgParamViewerCount,
    this.msgParamRitualName,
    this.msgParamThreshold,
    this.msgParamGiftMonths,
    required super.user,
    this.roomId = '',
    this.systemMsg = '',
    this.tmiSentTs = 0,
  }) : super(command: userNotice);

  /// The Twitch IRC server sends this message after the following events occur:
  /// A user subscribes to the channel, re-subscribes to the channel, or gifts a subscription to another user.
  /// A broadcaster raids the channel. Raid is a Twitch feature that lets broadcasters send their viewers to another channel to help support and grow other members in the community.
  /// A viewer milestone is celebrated such as a new viewer chatting for the first time. These celebrations are called rituals.
  factory UserNoticeMessage.fromMap(
      {String? channel,
      required TwitchClient client,
      required String? content,
      required Map<String, dynamic> map}) {
    List<Emote> emotes = map['emotes'] == null
        ? <Emote>[]
        : (map['emotes'] as String)
            .split(',')
            .map((e) => Emote.fromRawString(e))
            .toList();

    MessageUser user = MessageUser.fromMap(client, map);

    return UserNoticeMessage._(
      channel: channel ?? '',
      content: content ?? '',
      emotes: emotes,
      id: map['id'] ?? 0,
      login: map['login'] ?? '',
      msgId: map['msg-id'] ?? '',
      msgParamCumulativeMonths: map['msg-param-cumulative-months'] ?? 0,
      msgParamDisplayName: map['msg-param-displayName'] ?? '',
      msgParamLogin: map['msg-param-login'] ?? '',
      msgParamMonths: map['msg-param-months'] ?? 0,
      msgParamPromoGiftTotal: map['msg-param-promo-gift-total'] ?? 0,
      msgParamPromoName: map['msg-param-promo-name'] ?? '',
      msgParamRecipientDisplayName:
          map['msg-param-recipient-display-name'] ?? '',
      msgParamRecipientId: map['msg-param-recipient-id'] ?? 0,
      msgParamRecipientUserName: map['msg-param-recipient-user-name'] ?? '',
      msgParamSenderLogin: map['msg-param-sender-login'] ?? '',
      msgParamSenderName: map['msg-param-sender-name'] ?? '',
      msgParamShouldShareStreak: map['msg-param-should-share-streak'] ?? false,
      msgParamStreakMonths: map['msg-param-streak-months'] ?? 0,
      msgParamSubPlan: map['msg-param-sub-plan'] ?? '',
      msgParamSubPlanName: map['msg-param-sub-plan-name'] ?? '',
      msgParamViewerCount: map['msg-param-viewerCount'] ?? 0,
      msgParamRitualName: map['msg-param-ritual-name'] ?? '',
      msgParamThreshold: map['msg-param-threshold'] ?? 0,
      msgParamGiftMonths: map['msg-param-gift-months'] ?? 0,
      user: user,
      roomId: map['room-id'] ?? '',
      systemMsg: map['system-msg'] ?? '',
      tmiSentTs: map['tmi-sent-ts'] ?? 0,
    );
  }
}
