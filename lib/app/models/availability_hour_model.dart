/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import 'e_provider_model.dart';
import 'parents/model.dart';

class AvailabilityHour extends Model {
  String? _day;
  String? _startAt;
  String? _endAt;
  String? _data;
  EProvider? _eProvider;

  AvailabilityHour({String? id, String? day, String? startAt, String? endAt, String? data, EProvider? eProvider}) {
    _data = data;
    _endAt = endAt;
    _startAt = startAt;
    _day = day;
    _eProvider = eProvider;
    this.id = id;
  }

  AvailabilityHour.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _day = stringFromJson(json, 'day');
    _startAt = stringFromJson(json, 'start_at');
    _endAt = stringFromJson(json, 'end_at');
    _data = transStringFromJson(json, 'data');
    _eProvider =  objectFromJson(json, 'e_provider', (value) => EProvider.fromJson(value));
  }

  String toDuration() {
    return '$startAt - $endAt';
  }

  String get data => _data ?? '';

  set data(String? value) {
    _data = value;
  }

  String get day => _day ?? '';

  set day(String? value) {
    _day = value;
  }

  String get endAt => _endAt ?? '';

  set endAt(String? value) {
    _endAt = value;
  }

  String get startAt => _startAt ?? '';

  set startAt(String? value) {
    _startAt = value;
  }

  EProvider? get eProvider => _eProvider;

  set eProvider(EProvider? value) {
    _eProvider = value;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this._day;
    data['start_at'] = this._startAt;
    data['end_at'] = this._endAt;
    data['data'] = this._data;
    if (this.eProvider != null) data['e_provider_id'] = this.eProvider!.id;
    return data;
  }
}
