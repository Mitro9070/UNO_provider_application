import 'dart:math';

import 'package:get/get.dart';

import 'media_model.dart';
import 'parents/model.dart';
import 'wallet_model.dart';

class PaymentMethod extends Model {
  String? _name;
  String? _description;
  Media? _logo;
  String? _route;
  int? _order;
  bool? _isDefault;
  Wallet? _wallet;

  PaymentMethod({String? id, String? name, String? description, String? route, Wallet? wallet, bool? isDefault = false, Media? logo}) {
    this.id = id;
    _wallet = wallet;
    _isDefault = isDefault;
    _route = route;
    _description = description;
    _name = name;
    _logo = logo;
  }

  PaymentMethod.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _name = transStringFromJson(json, 'name');
    _description = transStringFromJson(json, 'description');
    _route = stringFromJson(json, 'route');
    _logo = mediaFromJson(json, 'logo');
    _order = intFromJson(json, 'order');
    _isDefault = boolFromJson(json, 'default');
  }

  String get description => _description ?? '';

  set description(String? value) {
    _description = value;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ name.hashCode ^ description.hashCode ^ route.hashCode ^ order.hashCode ^ wallet.hashCode;

  bool get isDefault => _isDefault ?? false;

  set isDefault(bool? value) {
    _isDefault = value;
  }

  Media get logo => _logo ?? Media();

  set logo(Media? value) {
    _logo = value;
  }

  String get name {
    _name = _name ?? "Not Paid".tr;
    return _name!.substring(_name!.length - min(_name!.length, 10), _name!.length);
  }

  set name(String? value) {
    _name = value;
  }

  int get order => _order ?? 0;

  set order(int? value) {
    _order = value;
  }

  String get route => _route ?? '';

  set route(String? value) {
    _route = value;
  }

  Wallet? get wallet => _wallet;

  set wallet(Wallet? value) {
    _wallet = value;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
          super == other &&
              other is PaymentMethod &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              description == other.description &&
              route == other.route &&
              order == other.order &&
              wallet == other.wallet;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
