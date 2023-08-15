import 'dart:collection';

import 'user_message.dart';

import '../emote.dart';

abstract base class EmoteMessage extends UserMessage {
  /// List of [Emote] in the message with their positions.
  final List<Emote> _emotes;

  /// List of [Emote] in the message with their positions.
  UnmodifiableListView<Emote> get emotes => UnmodifiableListView(_emotes);

  const EmoteMessage(
      {required List<Emote> emotes,
      required super.command,
      required super.user,
      required super.channel,
      required super.content})
      : _emotes = emotes;
}
