import '../raw/irc_message.dart';

import '../base/messages/message.dart';

/// The Twitch IRC server sends this message to indicate the outcome of the action
final class NoticeMessage extends Message {
  /// An ID that you can use to programmatically determine the action’s outcome.
  /// For a list of possible IDs, see NOTICE Message IDs.
  final String msgId;

  /// The ID of the user that the action targeted.
  final int targetUserId;

  /// The Twitch IRC server sends this message to indicate the outcome of the action
  @override
  NoticeMessage.parseIRC(IRCMessage ircMessage)
      : msgId = ircMessage.tags['msg-id']!,
        targetUserId = int.parse(ircMessage.tags['target-user-id']!),
        super.parseIRC(ircMessage);
}
