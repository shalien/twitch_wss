import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:tmi_dart/src/twitch_client.dart';

import 'raw_source.dart';

const List<String> _tagsToIgnore = ['client-nonce', 'flags'];

@immutable
@internal
final class IRCMessage {
  final Map<String, dynamic> _tags;

  final String? channel;

  final String command;

  final String? content;

  final RawSource? source;

  UnmodifiableMapView<String, dynamic> get tags => UnmodifiableMapView(_tags);

  final TwitchClient client;

  const IRCMessage._(this._tags,
      {required this.channel,
      required this.command,
      required this.content,
      required this.source,
      required this.client});

  factory IRCMessage.parse(
      {required TwitchClient client, required String raw}) {
    Map<String, dynamic> tags = <String, dynamic>{};
    RawSource? source;
    String? params;

    int startIndex = 0;
    int endIndex;

    /// Parsing tags
    if (raw[startIndex] == '@') {
      endIndex = raw.indexOf(' ', startIndex);

      raw.substring(startIndex, endIndex).split(';').forEach((element) {
        List<String> splittedTag = element.split('=');

        String key = splittedTag.first;

        if (key.startsWith('@')) {
          key = key.substring(1);
        }

        if (_tagsToIgnore.contains(key)) {
          return;
        }

        tags.putIfAbsent(key, () => splittedTag.last);
      });

      startIndex = endIndex + 1;
    }

    /// End parsing tags

    /// Parsing source
    if (raw[startIndex] == ':') {
      endIndex = raw.indexOf(' ', startIndex);
      source = RawSource.parse(raw.substring(startIndex, endIndex));
      startIndex = endIndex + 1;
    }

    /// End parsing source

    /// Parsing command
    endIndex = raw.indexOf(' ', startIndex);
    if (endIndex == -1) {
      endIndex = raw.length;
    }

    /// To ease the comparison we are using lowercase
    List<String> rawCommand =
        raw.substring(startIndex, endIndex).trim().split(' ');

    String command = rawCommand.first;

    /// End parsing command

    String? channel;

    /// Parsing params
    if (endIndex != raw.length) {
      startIndex = endIndex + 1;
      List<String> endLine = raw.substring(startIndex).trim().split(' ');

      channel = endLine.first;
      params = endLine.length <= 1
          ? null
          : endLine.sublist(1).join(' ').startsWith(':')
              ? endLine.sublist(1).join(' ').substring(1)
              : endLine.sublist(1).join(' ');
    }

    /// End parsing params

    return IRCMessage._(tags,
        source: source,
        channel: channel,
        command: command,
        content: params,
        client: client);
  }
}
