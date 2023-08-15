import 'package:tmi_dart/src/const/twitch_commands.dart';

import '../base/messages/user_message.dart';
import '../../tmi_dart.dart';

import '../base/user/message_user.dart';

/// The Twitch IRC server sends this message after the bot joins a channel or sends a [PrivMessage] message.
final class UserStateMessage extends UserMessage {
  /// 	If a [PrivMessage] was sent, an ID that uniquely identifies the message.
  final String id;

  /// The Twitch IRC server sends this message after the bot joins a channel or sends a [PrivMessage] message.
  UserStateMessage._(
      {required this.id, required super.user, required super.channel})
      : super(command: userState, content: null);

  /// The Twitch IRC server sends this message after the bot joins a channel or sends a [PrivMessage] message.
  factory UserStateMessage.fromMap(
      {required TwitchClient client,
      required String? channel,
      required Map<String, dynamic> map}) {
    MessageUser user = MessageUser.fromMap(client, map);

    return UserStateMessage._(
      channel: channel,
      id: map['id'],
      user: user,
    );
  }
}
