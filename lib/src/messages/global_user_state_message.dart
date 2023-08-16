import 'package:meta/meta.dart';

import '../base/messages/message.dart';
import '../raw/irc_message.dart';

/// The Twitch IRC server sends this message after the bot authenticates with the server.
@immutable
final class GlobalUserStateMessage extends Message {
  /// The Twitch IRC server sends this message after the bot authenticates with the server.
  @override
  GlobalUserStateMessage.parseIRC(IRCMessage ircMessage)
      : super.parseIRC(ircMessage);
}
