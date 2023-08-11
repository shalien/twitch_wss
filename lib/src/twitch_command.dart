import 'dart:convert';

import 'package:meta/meta.dart';

const String join = 'JOIN';
const String part = 'PART';
const String notice = 'NOTICE';
const String clearChat = 'CLEARCHAT';
const String hostTarget = 'HOSTTARGET';
const String privmsg = 'PRIVMSG';
const String ping = 'PING';
const String cap = 'CAP';
const String gloablUserState = 'GLOBALUSERSTATE';
const String roomState = 'ROOMSTATE';
const String userNotice = 'USERNOTICE';
const String reconnect = 'RECONNECT';

const String zeroZeroOne = '001';
const String zeroZeroTwo = '002';
const String zeroZeroThree = '003';
const String zeroZeroFour = '004';

const String threeFiveThree = '353';
const String threeSixSix = '366';
const String threeSevenTwo = '372';
const String threeSevenFive = '375';
const String threeSevenSix = '376';

const String fourTwoOne = '421';

@immutable
final class TwitchCommand {
  final String command;
  final String channel;
  final String? message;

  const TwitchCommand._(this.command, this.channel, this.message);

  factory TwitchCommand.parse(String raw) {
    List<String> parts = raw.split(' ');

    if (parts.length == 1) {
      return TwitchCommand._(parts.first.trim(), '', null);
    } else if (parts.length == 2) {
      return TwitchCommand._(parts.first.trim(), parts[1].trim(), null);
    } else {
      return TwitchCommand._(parts.first.trim(), parts[1].trim(),
          parts.map((e) => e.trim()).toList().sublist(2).join(' '));
    }
  }

  String toJson() {
    return jsonEncode({
      'command': command,
      'channel': channel,
      'message': message,
    });
  }
}
