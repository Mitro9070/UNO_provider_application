/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import 'media_model.dart';
import 'parents/model.dart';

class Gallery extends Model {
  Media? _image;
  String? _description;

  Gallery({String? id, String? description, Media? image}) {
    this.id = id;
    _description = description;
    _image = image;
  }

  Gallery.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _image = mediaFromJson(json, 'image');
    _description = transStringFromJson(json, 'description');
  }

  String get description => _description ?? '';

  set description(String? value) {
    _description = value;
  }

  Media get image => _image ?? Media();

  set image(Media? value) {
    _image = value;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    return data;
  }
}
