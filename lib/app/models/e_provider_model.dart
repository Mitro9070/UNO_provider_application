/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import 'address_model.dart';
import 'availability_hour_model.dart';
import 'e_provider_type_model.dart';
import 'media_model.dart';
import 'parents/model.dart';
import 'review_model.dart';
import 'tax_model.dart';
import 'user_model.dart';

class EProvider extends Model {
  String? _name;

  String? _description;

  List<Media>? _images;

  String? _phoneNumber;

  String? _mobileNumber;

  EProviderType? _type;

  List<AvailabilityHour>? _availabilityHours;

  double? _availabilityRange;

  bool? _available;

  bool? _featured;

  List<Address>? _addresses;

  List<Tax>? _taxes;

  List<User>? _employees;

  double? _rate;

  List<Review>? _reviews;

  int? _totalReviews;

  bool? _verified;

  int? _bookingsInProgress;

  EProvider(
      {String? id,
        String? name,
        String? description,
        String? phoneNumber,
        String? mobileNumber,
        EProviderType? type,
        List<AvailabilityHour>? availabilityHours,
        double? availabilityRange,
        bool? available,
        bool? featured,
        List<Address>? addresses,
        List<User>? employees,
        double? rate,
        List<Review>? reviews,
        int? totalReviews,
        bool? verified,
        int? bookingsInProgress}) {
    _bookingsInProgress = bookingsInProgress;
    _verified = verified;
    _totalReviews = totalReviews;
    _reviews = reviews;
    _rate = rate;
    _employees = employees;
    _addresses = addresses;
    _featured = featured;
    _available = available;
    _availabilityRange = availabilityRange;
    _availabilityHours = availabilityHours;
    _type = type;
    _mobileNumber = mobileNumber;
    _phoneNumber = phoneNumber;
    _description = description;
    _name = name;
    this.id = id;
  }

  EProvider.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _name = transStringFromJson(json, 'name');
    _description = transStringFromJson(json, 'description');
    _images = mediaListFromJson(json, 'images');
    _phoneNumber = stringFromJson(json, 'phone_number');
    _mobileNumber = stringFromJson(json, 'mobile_number');
    _type = objectFromJson(json, 'e_provider_type', (v) => EProviderType.fromJson(v));
    _availabilityHours = listFromJson(json, 'availability_hours', (v) => AvailabilityHour.fromJson(v));
    _availabilityRange = doubleFromJson(json, 'availability_range');
    _available = boolFromJson(json, 'available');
    _featured = boolFromJson(json, 'featured');
    _addresses = listFromJson(json, 'addresses', (v) => Address.fromJson(v));
    _taxes = listFromJson(json, 'taxes', (v) => Tax.fromJson(v));
    _employees = listFromJson(json, 'users', (v) => User.fromJson(v));
    _rate = doubleFromJson(json, 'rate');
    _reviews = listFromJson(json, 'e_provider_reviews', (v) => Review.fromJson(v));
    _totalReviews = reviews.isEmpty ? intFromJson(json, 'total_reviews') : reviews.length;
    _verified = boolFromJson(json, 'verified');
    _bookingsInProgress = intFromJson(json, 'bookings_in_progress');
  }

  List<Address> get addresses => _addresses ?? [];

  set addresses(List<Address>? value) {
    _addresses = value;
  }

  List<AvailabilityHour> get availabilityHours => _availabilityHours ?? [];

  set availabilityHours(List<AvailabilityHour>? value) {
    _availabilityHours = value;
  }

  double get availabilityRange => _availabilityRange ?? 0;

  set availabilityRange(double? value) {
    _availabilityRange = value;
  }

  bool get available => _available ?? false;

  set available(bool? value) {
    _available = value;
  }

  int get bookingsInProgress => _bookingsInProgress ?? 0;

  set bookingsInProgress(int? value) {
    _bookingsInProgress = value;
  }

  String get description => _description ?? '';

  set description(String? value) {
    _description = value;
  }

  List<User> get employees => _employees ?? [];

  set employees(List<User>? value) {
    _employees = value;
  }

  bool get featured => _featured ?? false;

  set featured(bool? value) {
    _featured = value;
  }

  String get firstAddress {
    if (this.addresses.isNotEmpty) {
      return this.addresses.first.address;
    }
    return '';
  }

  String get firstImageIcon => this.images.first.icon;

  String get firstImageThumb => this.images.first.thumb;

  String get firstImageUrl => this.images.first.url;

  @override
  bool get hasData {
    return super.hasData && _name != null && _description != null;
  }

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      images.hashCode ^
      phoneNumber.hashCode ^
      mobileNumber.hashCode ^
      type.hashCode ^
      availabilityRange.hashCode ^
      available.hashCode ^
      featured.hashCode ^
      addresses.hashCode ^
      rate.hashCode ^
      reviews.hashCode ^
      totalReviews.hashCode ^
      verified.hashCode ^
      bookingsInProgress.hashCode;

  List<Media> get images => _images ?? [];

  set images(List<Media>? value) {
    _images = value;
  }

  String get mobileNumber => _mobileNumber ?? '';

  set mobileNumber(String? value) {
    _mobileNumber = value;
  }

  String get name => _name ?? '';

  set name(String? value) {
    _name = value;
  }

  String get phoneNumber => _phoneNumber ?? '';

  set phoneNumber(String? value) {
    _phoneNumber = value;
  }

  double get rate => _rate ?? 0;

  set rate(double? value) {
    _rate = value;
  }

  List<Review> get reviews => _reviews ?? [];

  set reviews(List<Review>? value) {
    _reviews = value;
  }

  List<Tax> get taxes => _taxes ?? [];

  set taxes(List<Tax>? value) {
    _taxes = value;
  }

  int get totalReviews => _totalReviews ?? 0;

  set totalReviews(int? value) {
    _totalReviews = value;
  }

  EProviderType get type => _type ?? EProviderType();

  set type(EProviderType? value) {
    _type = value;
  }

  bool get verified => _verified ?? false;

  set verified(bool? value) {
    _verified = value;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
          super == other &&
              other is EProvider &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              description == other.description &&
              images == other.images &&
              phoneNumber == other.phoneNumber &&
              mobileNumber == other.mobileNumber &&
              type == other.type &&
              availabilityRange == other.availabilityRange &&
              available == other.available &&
              featured == other.featured &&
              addresses == other.addresses &&
              rate == other.rate &&
              reviews == other.reviews &&
              totalReviews == other.totalReviews &&
              verified == other.verified &&
              bookingsInProgress == other.bookingsInProgress;

  List<String> getAvailabilityHoursData(String day) {
    List<String> result = [];
    this.availabilityHours.forEach((element) {
      if (element.day == day) {
        result.add(element.data);
      }
    });
    return result;
  }

  Map<String, List<AvailabilityHour>> groupedAvailabilityHours() {
    Map<String, List<AvailabilityHour>> result = {};
    this.availabilityHours.forEach((element) {
      if (result.containsKey(element.day)) {
        result[element.day]!.add((element.startAt + ' - ' + element.endAt) as AvailabilityHour);
      } else {
        result[element.day] = [(element.startAt + ' - ' + element.endAt) as AvailabilityHour];
      }
    });
    return result;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['available'] = this.available;
    data['phone_number'] = this.phoneNumber;
    data['mobile_number'] = this.mobileNumber;
    data['rate'] = this.rate;
    data['total_reviews'] = this.totalReviews;
    data['verified'] = this.verified;
    data['bookings_in_progress'] = this.bookingsInProgress;
    return data;
  }
}
