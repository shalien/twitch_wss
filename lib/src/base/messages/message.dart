import 'package:meta/meta.dart';

@immutable
abstract base class Message {
  /// The command that was used to trigger this message.
  final String command;

  /// The channel that this message was sent in.
  final String? channel;

  /// The content of the message.
  final String? content;

  const Message(
      {required this.command, required this.channel, required this.content});
}
