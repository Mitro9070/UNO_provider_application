import 'package:get/get.dart';

import 'parents/model.dart';

class Notification extends Model {
  String? _type;
  Map<String, dynamic>? _data;
  bool? _read;
  DateTime? _createdAt;

  Notification({String? id}) {
    this.id = id;
  }

  Notification.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    type = stringFromJson(json, 'type');
    data = mapFromJson(json, 'data', defaultValue: {});
    read = boolFromJson(json, 'read_at');
    createdAt = dateFromJson(json, 'created_at', defaultValue: DateTime.now().toLocal());
  }

  DateTime get createdAt => _createdAt ?? DateTime.now().toLocal();

  set createdAt(DateTime? value) {
    _createdAt = value;
  }

  Map<String, dynamic> get data => _data ?? {};

  set data(Map<String, dynamic>? value) {
    _data = value;
  }

  bool get read => _read ?? false;

  set read(bool? value) {
    _read = value;
  }

  String get type => _type ?? '';

  set type(String? value) {
    _type = value;
  }

  String getMessage() {
    if (type == 'App\\Notifications\\NewMessage' && data['from'] != null) {
      return data['from'] + ' ' + type.tr;
    } else if (data['booking_id'] != null) {
      return '#' + data['booking_id'].toString() + ' ' + type.tr;
    } else {
      return type.tr;
    }
  }

  Map markReadMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["read_at"] = !read;
    return map;
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
