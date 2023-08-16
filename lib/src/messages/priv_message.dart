import 'dart:collection';

import 'package:meta/meta.dart';
import '../base/emote.dart';
import '../base/messages/message.dart';
import '../raw/irc_message.dart';

import '../mixin/has_emote.dart';

/// The Twitch IRC server sends this message after a user posts a message to the chat room.
@immutable
final class PrivMessage extends Message with hasEmote {
  /// Message id
  final String id;

  /// Hypechat content

  /// The value of the Hype Chat sent by the user.
  final int? pinnedChatPaidAmount;

  /// The ISO 4217 alphabetic currency code the user has sent the Hype Chat in.
  final String? pinnedChatPaidCurrency;

  /// Indicates how many decimal points this currency represents partial amounts in.
  /// Decimal points start from the right side of the value defined in [pinnedChatPaidAmount].
  final int? pinnedChatPaidExponent;

  /// The level of the Hype Chat, in English. Possible values are:
  /// ONE
  /// TWO
  /// THREE
  /// FOUR
  /// FIVE
  /// SIX
  /// SEVEN
  /// EIGHT
  /// NINE
  /// TEN
  final String? pinnedChatPaidLevel;

  /// A Boolean value that determines if the message sent with the Hype Chat was filled in by the system.
  /// If true (1), the user entered no message and the body message was automatically filled in by the system.
  /// If false (0), the user provided their own message to send with the Hype Chat.
  final int? _pinnedChatIsPaidSystemMessage;

  /// A Boolean value that determines if the message sent with the Hype Chat was filled in by the system.
  bool? get isSystemMessage => _pinnedChatIsPaidSystemMessage == 1;

  /// Threading

  /// An ID that uniquely identifies the direct parent message that this message is replying to.
  /// Will be null if this message is not a reply.
  final String? replyParentMessageId;

  /// The login name of the sender of the direct parent message.
  /// Will be null if this message is not a reply.
  final String? replyParentUserLogin;

  /// The display name of the sender of the direct parent message.
  /// Will be null if this message is not a reply.
  final String? replyParentDisplayName;

  /// The message text of the direct parent message.
  /// Will be null if this message is not a reply.
  final String? replyParentMessageBody;

  /// The ID of the first message that this message was replied to.
  /// Will be null if this message is not a reply.
  final String? replyThreadParentMessageId;

  /// The login name of the sender of the first message that this message was replied to.
  /// Will be null if this message is not a reply.
  final String? replyThreadParentUserLogin;

  /// The UNIX timestamp
  final int tmiSentTs;

  /// The ID of the room the message was sent to.
  final int roomId;

  final List<Emote> _emotes;

  /// The emotes that were used in this message.
  UnmodifiableListView get emotes => UnmodifiableListView(_emotes);

  /// The Twitch IRC server sends this message after a user posts a message to the chat room.
  PrivMessage.parseIRC(IRCMessage ircMessage)
      : id = ircMessage.tags['id'] as String,
        pinnedChatPaidAmount =
            ircMessage.tags['pinned-chat-paid-amount'] as int?,
        pinnedChatPaidCurrency =
            ircMessage.tags['pinned-chat-paid-currency'] as String?,
        pinnedChatPaidExponent =
            ircMessage.tags['pinned-chat-paid-exponent'] as int?,
        pinnedChatPaidLevel =
            ircMessage.tags['pinned-chat-paid-level'] as String?,
        _pinnedChatIsPaidSystemMessage =
            ircMessage.tags['pinned-chat-is-paid-system-message'] as int?,
        replyParentMessageId =
            ircMessage.tags['reply-parent-msg-id'] as String?,
        replyParentUserLogin =
            ircMessage.tags['reply-parent-user-login'] as String?,
        replyParentDisplayName =
            ircMessage.tags['reply-parent-display-name'] as String?,
        replyParentMessageBody =
            ircMessage.tags['reply-parent-msg-body'] as String?,
        replyThreadParentMessageId =
            ircMessage.tags['reply-thread-parent-msg-id'] as String?,
        replyThreadParentUserLogin =
            ircMessage.tags['reply-thread-parent-user-login'] as String?,
        tmiSentTs = ircMessage.tags['tmi-sent-ts'] as int,
        roomId = ircMessage.tags['room-id'] as int,
        _emotes = hasEmote.parseEmotes(ircMessage),
        super.parseIRC(ircMessage);
}
