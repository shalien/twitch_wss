import 'dart:collection';

import 'twitch_badge.dart';
import 'twitch_emote.dart';

import 'twitch_source.dart';

const List<String> _tagsToIgnore = ['client-nonce', 'flags'];

final class TwitchMessage {
  /// [Map] of the message tags.
  final UnmodifiableMapView<String, dynamic>? tags;

  /// [List] of the message [TwitchBadge].
  final UnmodifiableListView<TwitchBadge>? badges;

  /// [List] of the message [TwitchEmote].
  final UnmodifiableListView<TwitchEmote>? emotes;

  /// [List] of the message emote sets.
  final UnmodifiableListView<int>? emoteSets;

  final TwitchSource _source;
  final String _command;
  final String _params;

  TwitchMessage._(this._source, this._command, this._params, this.tags,
      this.badges, this.emotes, this.emoteSets);

  factory TwitchMessage.parse(String raw) {
    List<String> parts = raw.split(' ');
    _Tag? tag;
    late TwitchSource source;
    late String command;

    // Check if the message has tags.
    if (parts.first.startsWith('@')) {
      tag = _Tag.parse(parts.first);
      parts.removeAt(0);
    }

    // Check if the message has a source.
    if (parts.first.startsWith(':')) {
      source = TwitchSource.parse(parts.first);
      parts.removeAt(0);
    }

    // Check if the message has a command.
    if (!parts.first.startsWith(':')) {
      command = parts.first.trim();
    }

    return TwitchMessage._(source, parts[1], parts[2], tag?.tags, tag?.badges,
        tag?.emotes, tag?.emoteSets);
  }

  void parseSource(String raw) {
    throw UnimplementedError();
  }

  void _parseCommand(String raw) {
    List<String> parts = raw.split(' ');
  }

  String toJson() {
    throw UnimplementedError();
  }
}

final class _Tag {
  Map<String, dynamic>? _tags;

  UnmodifiableMapView<String, dynamic>? get tags =>
      _tags == null ? null : UnmodifiableMapView<String, dynamic>(_tags!);

  List<TwitchBadge>? _badges;

  UnmodifiableListView<TwitchBadge>? get badges =>
      _badges == null ? null : UnmodifiableListView<TwitchBadge>(_badges!);

  List<TwitchEmote>? _emotes;

  UnmodifiableListView<TwitchEmote>? get emotes =>
      _emotes == null ? null : UnmodifiableListView<TwitchEmote>(_emotes!);

  List<int>? _emoteSets;

  UnmodifiableListView<int>? get emoteSets =>
      _emoteSets == null ? null : UnmodifiableListView<int>(_emoteSets!);

  _Tag._(this._tags, this._badges, this._emotes, this._emoteSets);

  factory _Tag.parse(String raw) {
    Map<String, dynamic>? tags;

    List<TwitchBadge>? badges;
    List<TwitchEmote>? emotes;
    List<int>? emoteSets;

    List<String> splittedTags = raw.split(';');
    splittedTags.removeWhere((element) => _tagsToIgnore.contains(element));

    for (String tag in splittedTags) {
      List<String> parsedTag = tag.split('=');

      String key = parsedTag.first;

      switch (key) {
        case 'badges':
        case 'badge-info':
          badges ??= <TwitchBadge>[];

          for (String badge in parsedTag.last.split(',')) {
            badges.add(TwitchBadge.parse(badge));
          }
          break;

        case 'emotes':
          emotes ??= <TwitchEmote>[];

          for (String emote in parsedTag.last.split('/')) {
            emotes.add(TwitchEmote.parse(emote));
          }

          break;
        case 'emote-sets':
          emoteSets ??= <int>[];

          for (String emoteSet in parsedTag.last.split(',')) {
            emoteSets.add(int.parse(emoteSet));
          }
          break;
        default:
          tags ??= <String, String>{};

          if (_tagsToIgnore.contains(key)) {
            break;
          }

          tags.putIfAbsent(key, () => parsedTag.last);
          break;
      }
    }

    return _Tag._(tags, badges, emotes, emoteSets);
  }
}
