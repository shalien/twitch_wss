import 'package:meta/meta.dart';
import '../const/twitch_commands.dart';
import '../base/messages/user_message.dart';
import '../../tmi_dart.dart';

import '../base/user/user.dart';

/// The Twitch IRC server sends this message after the bot authenticates with the server.
@immutable
final class GlobarUserStateMessage extends UserMessage {
  /// The Twitch IRC server sends this message after the bot authenticates with the server.
  const GlobarUserStateMessage._({required User user})
      : super(
            command: globalUserState, user: user, content: null, channel: null);

  /// The Twitch IRC server sends this message after the bot authenticates with the server.
  factory GlobarUserStateMessage.fromMap(
      {required TwitchClient client, required Map<String, dynamic> data}) {
    return GlobarUserStateMessage._(user: User.fromMap(client, data));
  }
}
