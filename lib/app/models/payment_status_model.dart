import 'parents/model.dart';

class PaymentStatus extends Model {
  String? _status;

  String get status => _status ?? '';

  set status(String? value) {
    _status = value;
  }

  int? _order;

  int get order => _order ?? 0;

  set order(int? value) {
    _order = value;
  }

  PaymentStatus({String? id, String? status, int? order}) {
    _order = order;
    _status = status;
    this.id = id;
  }

  PaymentStatus.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _status = transStringFromJson(json, 'status');
    _order = intFromJson(json, 'order');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['order'] = this.order;
    return data;
  }
}
