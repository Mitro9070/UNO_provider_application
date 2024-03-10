/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import '../../common/uuid.dart';
import 'media_model.dart';
import 'parents/model.dart';

class EProviderDocument extends Model {
  String? _name;
  String? _type;
  List<Media>? _documents;

  EProviderDocument({String? name, String? type, List<Media>? documents})
      : _documents = documents,
        _type = type,
        _name = name;

  EProviderDocument.fromJson(Map<String, dynamic> json) {
    super.fromJson(json);
    _name = stringFromJson(json, 'name');
    _type = stringFromJson(json, 'type');
    _documents = mediaListFromJson(json, 'documents');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    if (this.documents != null) {
      data['image'] = this.documents?.where((element) => Uuid.isUuid(element.id)).map((v) => v.id).toList();
    }
    return data;
  }

  String? get name => _name;

  set name(String? value) {
    _name = value;
  }

  String? get type => _type;

  set type(String? value) {
    _type = value;
  }

  List<Media>? get documents => _documents;

  set documents(List<Media>? value) {
    _documents = value;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is EProviderDocument &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          type == other.type &&
          documents == other.documents;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ name.hashCode ^ type.hashCode ^ documents.hashCode;
}
