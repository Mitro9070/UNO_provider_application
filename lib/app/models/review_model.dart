/*
 * Copyright (c) 2020 .
 */
import 'e_service_model.dart';
import 'parents/model.dart';
import 'user_model.dart';

class Review extends Model {
  double? _rate;

  double get rate => _rate ?? 0;

  set rate(double? value) {
    _rate = value;
  }

  String? _review;

  String get review => _review ?? '';

  set review(String? value) {
    _review = value;
  }

  DateTime? _createdAt;

  DateTime get createdAt => _createdAt ?? DateTime.now().toLocal();

  set createdAt(DateTime? value) {
    _createdAt = value;
  }

  User? _user;

  User get user => _user ?? User();

  set user(User? value) {
    _user = value;
  }

  EService? _eService;

  EService get eService => _eService ?? EService();

  set eService(EService? value) {
    _eService = value;
  }

  Review({String? id, double? rate, String? review, DateTime? createdAt, User? user, EService? eService}) {
    _eService = eService;
    _user = user;
    _createdAt = createdAt;
    _review = review;
    _rate = rate;
    this.id = id;
  }

  Review.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _rate = doubleFromJson(json, 'rate');
    _review = stringFromJson(json, 'review');
    _createdAt = dateFromJson(json, 'created_at', defaultValue: DateTime.now().toLocal());
    _user = objectFromJson(json, 'user', (v) => User.fromJson(v));
    _eService = objectFromJson(json, 'e_service', (v) => EService.fromJson(v));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['rate'] = this.rate;
    data['review'] = this.review;
    data['created_at'] = this.createdAt;
    if (this.user.hasData) {
      data['user_id'] = this.user.id;
    }
    if (this.eService.hasData) {
      data['e_service_id'] = this.eService.id;
    }
    return data;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
          super == other &&
              other is Review &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              rate == other.rate &&
              review == other.review &&
              createdAt == other.createdAt &&
              user == other.user &&
              eService == other.eService;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ rate.hashCode ^ review.hashCode ^ createdAt.hashCode ^ user.hashCode ^ eService.hashCode;
}
