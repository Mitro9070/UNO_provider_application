import 'dart:math';

import 'parents/model.dart';
import 'user_model.dart';

enum TransactionActions { CREDIT, DEBIT }

class WalletTransaction extends Model {
  double? _amount;

  double get amount => _amount ?? 0;

  set amount(double? value) {
    _amount = value;
  }

  String? _description;

  String get description {
    _description = _description ?? '';
    return _description!.substring(_description!.length - min(_description!.length, 20), _description!.length);
  }

  set description(String? value) {
    _description = value;
  }

  TransactionActions? _action;

  TransactionActions get action => _action ?? TransactionActions.CREDIT;

  set action(TransactionActions? value) {
    _action = value;
  }

  DateTime? _dateTime;

  DateTime get dateTime => _dateTime ?? DateTime.now().toLocal();

  set dateTime(DateTime? value) {
    _dateTime = value;
  }

  User? _user;

  User get user => _user ?? User();

  set user(User? value) {
    _user = value;
  }

  WalletTransaction({String? id, double? amount, String? description, TransactionActions? action, User? user, DateTime? dateTime}) {
    _user = user;
    _dateTime = dateTime;
    _action = action;
    _description = description;
    _amount = amount;
    this.id = id;
  }

  WalletTransaction.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _description = stringFromJson(json, 'description');
    _amount = doubleFromJson(json, 'amount');
    _user = objectFromJson(json, 'user', (value) => User.fromJson(value));
    _dateTime = dateFromJson(json, 'created_at', defaultValue: null);
    if (json != null) {
      if (json['action'] == 'credit') {
        _action = TransactionActions.CREDIT;
      } else if (json['action'] == 'debit') {
        _action = TransactionActions.DEBIT;
      }
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['action'] = this.action;
    data['user'] = this.user;
    return data;
  }
}
