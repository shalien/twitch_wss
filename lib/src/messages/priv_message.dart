import 'package:meta/meta.dart';
import '../base/messages/emote_message.dart';

import '../base/emote.dart';
import '../base/user/message_user.dart';
import '../const/twitch_commands.dart';

/// The Twitch IRC server sends this message after a user posts a message to the chat room.
@immutable
final class PrivMessage extends EmoteMessage {
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

  /// The Twitch IRC server sends this message after a user posts a message to the chat room.
  const PrivMessage._(
    this._pinnedChatIsPaidSystemMessage,
    this.pinnedChatPaidAmount,
    this.pinnedChatPaidCurrency,
    this.pinnedChatPaidExponent,
    this.pinnedChatPaidLevel,
    this.replyParentMessageId,
    this.replyParentUserLogin,
    this.replyParentDisplayName,
    this.replyParentMessageBody,
    this.replyThreadParentMessageId,
    this.replyThreadParentUserLogin, {
    required super.user,
    required this.id,
    required super.content,
    required this.tmiSentTs,
    required this.roomId,
    required super.channel,
    required super.emotes,
  }) : super(command: privmsg);

  /// The Twitch IRC server sends this message after a user posts a message to the chat room.
  factory PrivMessage.fromMap(
      {required MessageUser user,
      required String channel,
      required String content,
      required Map<String, dynamic> map}) {
    return PrivMessage._(
      map['pinnedChatIsPaidSystemMessage'] as int?,
      map['pinnedChatPaidAmount'] as int?,
      map['pinnedChatPaidCurrency'] as String?,
      map['pinnedChatPaidExponent'] as int?,
      map['pinnedChatPaidLevel'] as String?,
      map['replyParentMessageId'] as String?,
      map['replyParentUserLogin'] as String?,
      map['replyParentDisplayName'] as String?,
      map['replyParentMessageBody'] as String?,
      map['replyThreadParentMessageId'] as String?,
      map['replyThreadParentUserLogin'] as String?,
      user: user,
      id: map['id'] as String,
      content: content,
      tmiSentTs: map['tmiSentTs'] as int,
      roomId: map['roomId'] as int,
      emotes: map['emotes'] == null
          ? <Emote>[]
          : (map['emotes'] as String)
              .split(',')
              .map((e) => Emote.fromRawString(e))
              .toList(),
      channel: channel,
    );
  }
}
