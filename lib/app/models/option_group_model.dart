import 'option_model.dart';
import 'parents/model.dart';

class OptionGroup extends Model {
  String? _name;
  bool? _allowMultiple;
  List<Option>? _options;

  OptionGroup({String? id, String? name, List<Option>? options}) {
    this.id = id;
    _options = options;
    _name = name;
  }

  OptionGroup.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    name = transStringFromJson(json, 'name');
    allowMultiple = boolFromJson(json, 'allow_multiple');
    options = listFromJson(json, 'options', (v) => Option.fromJson(v));
  }

  bool get allowMultiple => _allowMultiple ?? false;

  set allowMultiple(bool? value) {
    _allowMultiple = value;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ name.hashCode ^ allowMultiple.hashCode ^ options.hashCode;

  String get name => _name ?? '';

  set name(String? value) {
    _name = value;
  }

  List<Option> get options => _options ?? [];

  set options(List<Option>? value) {
    _options = value;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
          super == other &&
              other is OptionGroup &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              allowMultiple == other.allowMultiple &&
              options == other.options;

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["allow_multiple"] = allowMultiple;
    return map;
  }
}
