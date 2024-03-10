import 'parents/model.dart';

class Tax extends Model {
  String? _name;

  String get name => _name ?? '';

  set name(String? value) {
    _name = value;
  }

  String? _type;

  String get type => _type ?? '';

  set type(String? value) {
    _type = value;
  }

  double? _value;

  double get value => _value ?? 0;

  set value(double? value) {
    _value = value;
  }

  Tax({String? id, String? name, String? type, double? value}) {
    _value = value;
    _type = type;
    _name = name;
    this.id = id;
  }

  Tax.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _name = transStringFromJson(json, 'name');
    _type = stringFromJson(json, 'type');
    _value = doubleFromJson(json, 'value');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    data['type'] = this.type;
    return data;
  }
}
