import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import "parents/model.dart";
import 'user_model.dart';

class Chat extends Model {
  // message text
  String? _text;

  // time of the message
  int? _time;

  // user id who send the message
  String? _userId;

  User? _user;

  Chat(this._text, this._time, this._userId, this._user) {
    // generate unique id
    this.id = UniqueKey().toString();
  }

  Chat.fromDocumentSnapshot(DocumentSnapshot jsonMap) {
    try {
      id = jsonMap.id;
      text = jsonMap.get('text') != null ? jsonMap.get('text').toString() : '';
      time = jsonMap.get('time') != null ? jsonMap.get('time') : 0;
      userId = jsonMap.get('user') != null ? jsonMap.get('user').toString() : null;
    } catch (e) {
      id = null;
      text = '';
      time = 0;
      user = null;
      userId = null;
      print(e);
    }
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ text.hashCode ^ time.hashCode ^ userId.hashCode;

  String get text => _text ?? '';

  set text(String? value) {
    _text = value;
  }

  int get time => _time ?? 0;

  set time(int? value) {
    _time = value;
  }

  User get user => _user ?? User();

  set user(User? value) {
    _user = value;
  }

  String get userId => _userId ?? '';

  set userId(String? value) {
    _userId = value;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
          super == other && other is Chat && runtimeType == other.runtimeType && id == other.id && text == other.text && time == other.time && userId == other.userId;

  @override
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["text"] = text;
    map["time"] = time;
    map["user"] = userId;
    return map;
  }
}
