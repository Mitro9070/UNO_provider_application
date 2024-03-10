import 'package:flutter/material.dart';

import 'e_service_model.dart';
import 'media_model.dart';
import 'parents/model.dart';

class Category extends Model {
  String? _name;
  String? _description;
  Color? _color;
  Media? _image;
  bool? _featured;
  List<Category>? _subCategories;
  List<EService>? _eServices;

  Category({String? id, String? name, String? description, Color? color, bool? featured, List<Category>? subCategories, List<EService>? eServices}) {
    this.id = id;
    _color = color;
    _name = name;
    _description = description;
    _featured = featured;
    _subCategories = subCategories;
    _eServices = eServices;
  }

  Category.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _name = transStringFromJson(json, 'name');
    _color = colorFromJson(json, 'color');
    _description = transStringFromJson(json, 'description');
    _image = mediaFromJson(json, 'image');
    _featured = boolFromJson(json, 'featured');
    _eServices = listFromJsonArray(json, ['e_services', 'featured_e_services'], (v) => EService.fromJson(v));
    _subCategories = listFromJson(json, 'sub_categories', (v) => Category.fromJson(v));
  }

  Color get color => _color ?? Colors.white24;

  set color(Color? value) {
    _color = value;
  }

  String get description => _description ?? '';

  set description(String? value) {
    _description = value;
  }

  List<EService> get eServices => _eServices ?? [];

  set eServices(List<EService>? value) {
    _eServices = value;
  }

  bool get featured => _featured ?? false;

  set featured(bool? value) {
    _featured = value;
  }

  @override
  int get hashCode =>
      super.hashCode ^ id.hashCode ^ name.hashCode ^ description.hashCode ^ color.hashCode ^ image.hashCode ^ featured.hashCode ^ subCategories.hashCode ^ eServices.hashCode;

  Media get image => _image ?? Media();

  set image(Media? value) {
    _image = value;
  }

  String get name => _name ?? '';

  set name(String? value) {
    _name = value;
  }

  List<Category> get subCategories => _subCategories ?? [];

  set subCategories(List<Category>? value) {
    _subCategories = value;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
          super == other &&
              other is Category &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              description == other.description &&
              color == other.color &&
              image == other.image &&
              featured == other.featured &&
              subCategories == other.subCategories &&
              eServices == other.eServices;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['color'] = '#${this.color.value.toRadixString(16)}';
    return data;
  }
}
