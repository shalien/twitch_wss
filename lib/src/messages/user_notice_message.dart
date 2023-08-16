import 'dart:collection';

import 'package:tmi_dart/src/base/messages/message.dart';
import 'package:tmi_dart/src/mixin/has_emote.dart';
import 'package:tmi_dart/src/raw/irc_message.dart';

import '../base/emote.dart';

/// The Twitch IRC server sends this message after the following events occur:
/// A user subscribes to the channel, re-subscribes to the channel, or gifts a subscription to another user.
/// A broadcaster raids the channel. Raid is a Twitch feature that lets broadcasters send their viewers to another channel to help support and grow other members in the community.
/// A viewer milestone is celebrated such as a new viewer chatting for the first time. These celebrations are called rituals.
final class UserNoticeMessage extends Message with hasEmote {
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

  final List<Emote> _emotes;

  /// The emotes that were used in this message.
  UnmodifiableListView get emotes => UnmodifiableListView(_emotes);

  /// The Twitch IRC server sends this message after the following events occur:
  /// A user subscribes to the channel, re-subscribes to the channel, or gifts a subscription to another user.
  /// A broadcaster raids the channel. Raid is a Twitch feature that lets broadcasters send their viewers to another channel to help support and grow other members in the community.
  /// A viewer milestone is celebrated such as a new viewer chatting for the first time. These celebrations are called rituals.
  @override
  UserNoticeMessage.parseIRC(IRCMessage ircMessage)
      : id = int.tryParse(ircMessage.tags['id'] ?? '') ?? 0,
        login = ircMessage.tags['login'] ?? '',
        msgId = ircMessage.tags['msg-id'] ?? '',
        msgParamCumulativeMonths =
            int.tryParse(ircMessage.tags['msg-param-cumulative-months'] ?? ''),
        msgParamDisplayName = ircMessage.tags['msg-param-displayName'] ?? '',
        msgParamLogin = ircMessage.tags['msg-param-login'] ?? '',
        msgParamMonths =
            int.tryParse(ircMessage.tags['msg-param-months'] ?? ''),
        msgParamPromoGiftTotal =
            int.tryParse(ircMessage.tags['msg-param-promo-gift-total'] ?? ''),
        msgParamPromoName = ircMessage.tags['msg-param-promo-name'] ?? '',
        msgParamRecipientDisplayName =
            ircMessage.tags['msg-param-recipient-display-name'] ?? '',
        msgParamRecipientId =
            int.tryParse(ircMessage.tags['msg-param-recipient-id'] ?? ''),
        msgParamRecipientUserName =
            ircMessage.tags['msg-param-recipient-user-name'] ?? '',
        msgParamSenderLogin = ircMessage.tags['msg-param-sender-login'] ?? '',
        msgParamSenderName = ircMessage.tags['msg-param-sender-name'] ?? '',
        msgParamShouldShareStreak =
            ircMessage.tags['msg-param-should-share-streak'] == '1',
        msgParamStreakMonths =
            int.tryParse(ircMessage.tags['msg-param-streak-months'] ?? ''),
        msgParamSubPlan = ircMessage.tags['msg-param-sub-plan'] ?? '',
        msgParamSubPlanName = ircMessage.tags['msg-param-sub-plan-name'] ?? '',
        msgParamViewerCount =
            int.tryParse(ircMessage.tags['msg-param-viewerCount'] ?? ''),
        msgParamRitualName = ircMessage.tags['msg-param-ritual-name'] ?? '',
        msgParamThreshold =
            int.tryParse(ircMessage.tags['msg-param-threshold'] ?? ''),
        msgParamGiftMonths =
            int.tryParse(ircMessage.tags['msg-param-gift-months'] ?? ''),
        roomId = ircMessage.tags['room-id'] ?? '',
        systemMsg = ircMessage.tags['system-msg'] ?? '',
        tmiSentTs = int.tryParse(ircMessage.tags['tmi-sent-ts'] ?? '') ?? 0,
        _emotes = hasEmote.parseEmotes(ircMessage.tags['emotes'] ?? ''),
        super.parseIRC(ircMessage);
}
