import 'package:get/get.dart';

import 'parents/model.dart';
import 'payment_method_model.dart';
import 'payment_status_model.dart';

class Payment extends Model {
  String? _description;
  double? _amount;
  PaymentMethod? _paymentMethod;
  PaymentStatus? _paymentStatus;

  Payment({String? id, String? description, double? amount, PaymentMethod? paymentMethod, PaymentStatus? paymentStatus}) {
    this.id = id;
    _paymentStatus = paymentStatus;
    _paymentMethod = paymentMethod;
    _amount = amount;
    _description = description;
  }

  Payment.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _description = stringFromJson(json, 'description');
    _amount = doubleFromJson(json, 'amount');
    _paymentMethod = objectFromJson(json, 'payment_method', (v) => PaymentMethod.fromJson(v));
    _paymentStatus = objectFromJson(json, 'payment_status', (v) => PaymentStatus.fromJson(v));
  }

  double get amount => _amount ?? 0;

  set amount(double? value) {
    _amount = value;
  }

  String get description => _description ?? '';

  set description(String? value) {
    _description = value;
  }

  PaymentMethod get paymentMethod => _paymentMethod ?? PaymentMethod();

  set paymentMethod(PaymentMethod? value) {
    _paymentMethod = value;
  }

  PaymentStatus get paymentStatus => _paymentStatus ?? PaymentStatus(status: "Not Paid".tr);

  set paymentStatus(PaymentStatus? value) {
    _paymentStatus = value;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['amount'] = this.amount;
    if (paymentMethod.hasData) {
      data['payment_method_id'] = this.paymentMethod.id;
    }
    if (paymentStatus.hasData) {
      data['payment_status_id'] = this.paymentStatus.id;
    }
    return data;
  }
}
