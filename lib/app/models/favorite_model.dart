import 'e_service_model.dart';
import 'option_model.dart';
import 'parents/model.dart';

class Favorite extends Model {
  EService? _eService;
  List<Option>? _options;
  String? _userId;

  Favorite({String? id, EService? eService, List<Option>? options, String? userId}) {
    _userId = userId;
    _options = options;
    _eService = eService;
    this.id = id;
  }

  Favorite.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    eService = objectFromJson(json, 'e_service', (v) => EService.fromJson(v));
    options = listFromJson(json, 'options', (v) => Option.fromJson(v));
    userId = stringFromJson(json, 'user_id');
  }

  EService get eService => _eService ?? EService();

  set eService(EService? value) {
    _eService = value;
  }

  List<Option> get options => _options ?? [];

  set options(List<Option>? value) {
    _options = value;
  }

  String get userId => _userId ?? '';

  set userId(String? value) {
    _userId = value;
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["e_service_id"] = eService.id;
    map["user_id"] = userId;
    if (_options is List<Option>) {
      map["options"] = options.map((element) => element.id).toList();
    }
    return map;
  }
}
