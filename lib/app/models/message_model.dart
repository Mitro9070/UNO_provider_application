import 'package:cloud_firestore/cloud_firestore.dart';

import 'parents/model.dart';
import 'user_model.dart';

class Message extends Model {
  // conversation name for example chat with market name
  String? _name;

  String get name => _name ?? '';

  set name(String? value) {
    _name = value;
  }

  // Chats messages
  String? _lastMessage;

  String get lastMessage => _lastMessage ?? '';

  set lastMessage(String? value) {
    _lastMessage = value;
  }

  int? _lastMessageTime;

  int get lastMessageTime => _lastMessageTime ?? 0;

  set lastMessageTime(int? value) {
    _lastMessageTime = value;
  }

  // Ids of users that read the chat message
  List<String>? _readByUsers;

  List<String> get readByUsers => _readByUsers ?? [];

  set readByUsers(List<String>? value) {
    _readByUsers = value;
  }

  // Ids of users in this conversation
  List<String>? _visibleToUsers;

  List<String> get visibleToUsers => _visibleToUsers ?? [];

  set visibleToUsers(List<String>? value) {
    _visibleToUsers = value;
  }

  // users in the conversation
  List<User>? _users;

  List<User> get users => _users ?? [];

  set users(List<User>? value) {
    _users = value;
  }

  Message(this._users, {String? id = null, String? name = ''}) {
    this.id = id;
    _name = name;
    visibleToUsers = this.users.map((user) => user.id).toList();
    readByUsers = [];
  }

  Message.fromDocumentSnapshot(DocumentSnapshot jsonMap) {
    try {
      id = jsonMap.id;
      _name = jsonMap.get('name') != null ? jsonMap.get('name').toString() : '';
      _readByUsers = jsonMap.get('read_by_users') != null ? List.from(jsonMap.get('read_by_users')) : [];
      _visibleToUsers = jsonMap.get('visible_to_users') != null ? List.from(jsonMap.get('visible_to_users')) : [];
      _lastMessage = jsonMap.get('message') != null ? jsonMap.get('message').toString() : '';
      _lastMessageTime = jsonMap.get('time') != null ? jsonMap.get('time') : 0;
      _users = jsonMap.get('users') != null
          ? List.from(jsonMap.get('users')).map((element) {
        element['media'] = [
          {'thumb': element['thumb']}
        ];
        return User.fromJson(element);
      }).toList()
          : [];
    } catch (e) {
      id = '';
      _name = '';
      _readByUsers = [];
      _users = [];
      _lastMessage = '';
      _lastMessageTime = 0;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["users"] = users.map((element) => element.toRestrictMap()).toSet().toList();
    map["visible_to_users"] = users.map((element) => element.id).toSet().toList();
    map["read_by_users"] = readByUsers;
    map["message"] = lastMessage;
    map["time"] = lastMessageTime;
    return map;
  }

  Map<String, dynamic> toUpdatedMap() {
    var map = new Map<String, dynamic>();
    map["message"] = lastMessage;
    map["time"] = lastMessageTime;
    map["read_by_users"] = readByUsers;
    return map;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
          super == other &&
              other is Message &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              lastMessage == other.lastMessage &&
              lastMessageTime == other.lastMessageTime &&
              readByUsers == other.readByUsers &&
              visibleToUsers == other.visibleToUsers &&
              users == other.users;

  @override
  int get hashCode =>
      super.hashCode ^ id.hashCode ^ name.hashCode ^ lastMessage.hashCode ^ lastMessageTime.hashCode ^ readByUsers.hashCode ^ visibleToUsers.hashCode ^ users.hashCode;
}
