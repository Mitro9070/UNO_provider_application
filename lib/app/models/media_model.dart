import 'package:get/get.dart';

import '../services/global_service.dart';
import 'parents/model.dart';

class Media extends Model {
  String? name;
  String? _url;
  String? _thumb;
  String? _icon;
  String? size;

  String get url => _url ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";

  String get thumb => _thumb ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";

  String get icon => _icon ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";

  set url(String? value) {
    _url = value ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
  }

  set icon(String? value) {
    _icon = value ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
  }

  set thumb(String? value) {
    _thumb = value ?? "${Get.find<GlobalService>().baseUrl}images/image_default.png";
  }

  Media({String? id, String? url, String? thumb, String? icon}) {
    this.id = id;
    this.url = url;
    this.thumb = thumb;
    this.icon = icon;
  }

  Media.fromJson(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      name = jsonMap['name'];
      url = jsonMap['url'];
      thumb = jsonMap['thumb'];
      icon = jsonMap['icon'];
      size = jsonMap['formatted_size'];
    } catch (e) {
      url = "${Get.find<GlobalService>().baseUrl}images/image_default.png";
      thumb = "${Get.find<GlobalService>().baseUrl}images/image_default.png";
      icon = "${Get.find<GlobalService>().baseUrl}images/image_default.png";
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["name"] = name;
    map["url"] = url;
    map["thumb"] = thumb;
    map["icon"] = icon;
    map["formatted_size"] = size;
    return map;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
          super == other &&
              other is Media &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              url == other.url &&
              thumb == other.thumb &&
              icon == other.icon &&
              size == other.size;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ name.hashCode ^ url.hashCode ^ thumb.hashCode ^ icon.hashCode ^ size.hashCode;
}
