import 'dart:collection';
import 'dart:convert';

import 'package:twitch_wss/src/twitch_command.dart';

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

  final TwitchSource? source;
  final TwitchCommand? command;
  final String? params;

  TwitchMessage._(this.source, this.command, this.params, this.tags,
      this.badges, this.emotes, this.emoteSets);

  factory TwitchMessage.parse(String raw) {
    List<String> parts = raw.split(' ');
    _Tag? tag;
    TwitchSource? source;
    TwitchCommand? command;
    String? params;

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

    if (parts.isNotEmpty) {
      StringBuffer commandBuffer = StringBuffer();

      // Check if the message has params.
      while (!parts.first.startsWith(':')) {
        commandBuffer.write('${parts.first} ');
        parts.removeAt(0);
      }

      if (commandBuffer.isNotEmpty) {
        command = TwitchCommand.parse(commandBuffer.toString());
      }

      params = parts.join(' ').trim().substring(1);
    }

    return TwitchMessage._(source, command, params, tag?.tags, tag?.badges,
        tag?.emotes, tag?.emoteSets);
  }

  String toJson() {
    return jsonEncode({
      'source': source,
      'command': command,
      'params': params,
      'tags': tags,
      'badges': badges?.map((e) => e.toJson()).toList(),
      'emotes': emotes?.map((e) => e.toJosn()).toList(),
      'emoteSets': emoteSets,
    });
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

      if (key.startsWith('@')) {
        key = key.substring(1);
      }

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
