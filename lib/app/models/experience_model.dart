/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import 'parents/model.dart';

class Experience extends Model {
  String? _title;

  String? _description;

  Experience({String? id, String? title, String? description}) {
    _description = description;
    _title = title;
    this.id = id;
  }

  Experience.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _title = transStringFromJson(json, 'title');
    _description = transStringFromJson(json, 'description');
  }

  String get description => _description ?? '';

  set description(String? value) {
    _description = value;
  }

  String get title => _title ?? '';

  set title(String? value) {
    _title = value;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
