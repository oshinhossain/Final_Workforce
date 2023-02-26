//import 'package:flutter/material.dart';

class Conversation {
  String? lastMessage;
  String? name;
  String? time;
  int? unseenMessageCount;
  String? avatar;
  // Color? color;

  Conversation(
    this.avatar,
    this.lastMessage,
    this.name,
    this.time,
    this.unseenMessageCount,
    // this.color,
  );
}
