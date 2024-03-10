import 'dart:math';

import '../../common/uuid.dart';
import 'parents/model.dart';

class Wallet extends Model {
  String? _name;

  String get name {
    _name = _name ?? '';
    return _name!.substring(_name!.length - min(_name!.length, 16), _name!.length);
  }

  set name(String? value) {
    _name = value;
  }

  double? _balance;

  double get balance => _balance ?? 0;

  set balance(double? value) {
    _balance = value;
  }

  Wallet({String? id, String? name, double? balance}) {
    this.id = id;
    _balance = balance;
    _name = name;
  }

  Wallet.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _name = stringFromJson(json, 'name');
    _balance = doubleFromJson(json, 'balance');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.hasData) {
      data['id'] = this.id;
    }
    if (_name != null) {
      data['name'] = this.name;
    }
    if (_balance != null) {
      data['balance'] = this.balance;
    }
    return data;
  }

  String getId() {
    if (Uuid.isUuid(id)) {
      return id.substring(0, 3) + ' . . . ' + id.substring(id.length - 5, id.length);
    } else {
      return id;
    }
  }
}
