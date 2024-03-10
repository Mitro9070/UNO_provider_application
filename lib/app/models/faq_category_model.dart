import 'parents/model.dart';

class FaqCategory extends Model {
  String? _name;

  FaqCategory({String? id, String? name}) {
    _name = name;
    this.id = id;
  }

  FaqCategory.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _name = transStringFromJson(json, 'name');
  }

  String get name => _name ?? '';

  set name(String? value) {
    _name = value;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
