import 'dart:convert';

import 'package:meta/meta.dart';

const String join = 'join';
const String part = 'part';
const String notice = 'notice';
const String clearChat = 'clearchat';
const String hostTarget = 'hosttarget';
const String privmsg = 'privmsg';
const String ping = 'ping';
const String cap = 'cap';
const String gloablUserState = 'globaluserstate';
const String roomState = 'roomstate';
const String userNotice = 'usernotice';
const String reconnect = 'reconnect';

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
      return TwitchCommand._(parts.first, '', null);
    } else if (parts.length == 2) {
      return TwitchCommand._(parts.first, parts[1], null);
    } else {
      return TwitchCommand._(parts.first, parts[1], parts.sublist(2).join(' '));
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
