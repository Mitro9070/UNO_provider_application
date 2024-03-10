import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'parents/model.dart';

class Address extends Model {
  String? _description;
  String? _address;
  double? _latitude;
  double? _longitude;
  bool? _isDefault;
  String? _userId;

  Address({String? id, String? description, String? address, double? latitude, double? longitude, String? userId, bool? isDefault}) {
    _userId = userId;
    _longitude = longitude;
    _latitude = latitude;
    _address = address;
    _description = description;
    this.id = id;
  }

  Address.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _description = stringFromJson(json, 'description');
    _address = stringFromJson(json, 'address');
    _latitude = doubleFromJson(json, 'latitude', decimal: 10);
    _longitude = doubleFromJson(json, 'longitude', decimal: 10);
    _isDefault = boolFromJson(json, 'default');
    _userId = stringFromJson(json, 'user_id');
  }

  String get address => _address ?? '';

  set address(String? value) {
    _address = value;
  }

  String get description {
    if (hasDescription()) return _description!;
    return address.substring(0, min(address.length, 10));
  }

  set description(String? value) {
    _description = value;
  }

  bool get isDefault => _isDefault ?? false;

  set isDefault(bool? value) {
    _isDefault = value;
  }

  double get latitude => _latitude ?? 0;

  set latitude(double? value) {
    _latitude = value;
  }

  double get longitude => _longitude ?? 0;

  set longitude(double? value) {
    _longitude = value;
  }

  String get userId => _userId ?? '';

  set userId(String? value) {
    _userId = value;
  }

  LatLng getLatLng() {
    if (this.isUnknown()) {
      return LatLng(38.806103, 52.4964453);
    } else {
      return LatLng(this.latitude, this.longitude);
    }
  }

  bool hasDescription() {
    if (_description != null && (_description?.isNotEmpty ?? false)) return true;
    return false;
  }

  bool isUnknown() {
    return _latitude == 0 && _longitude == 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.hasData) {
      data['id'] = this.id;
    }
    if (this._description != null) {
      data['description'] = this._description;
    }
    if (this._address != null) {
      data['address'] = this._address;
    }
    if (this._latitude != null) {
      data['latitude'] = this._latitude;
    }
    if (this._longitude != null) {
      data['longitude'] = this._longitude;
    }
    if (this._isDefault != null) {
      data['default'] = this._isDefault;
    }
    if (this._userId != null) {
      data['user_id'] = this._userId;
    }
    return data;
  }
}
