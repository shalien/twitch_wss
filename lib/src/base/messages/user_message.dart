import 'package:meta/meta.dart';

import 'message.dart';

import '../user/user.dart';

@immutable
@internal
abstract base class UserMessage extends Message {
  /// The user that sent the message.
  final User user;

  const UserMessage(
      {required super.command,
      required this.user,
      required super.channel,
      required super.content});
}
