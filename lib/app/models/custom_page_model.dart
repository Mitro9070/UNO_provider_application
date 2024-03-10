import 'parents/model.dart';

class CustomPage extends Model {
  String? _title;

  String? get title => _title;

  set title(String? value) {
    _title = value;
  }

  String? _content;

  String? get content => _content;

  set content(String? value) {
    _content = value;
  }

  DateTime? _updatedAt;

  DateTime? get updatedAt => _updatedAt;

  set updatedAt(DateTime? value) {
    _updatedAt = value;
  }

  CustomPage({String? id, String? title, String? content, DateTime? updatedAt})
      : _updatedAt = updatedAt,
        _content = content,
        _title = title {
    this.id = id;
  }

  CustomPage.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    title = transStringFromJson(json, 'title');
    content = transStringFromJson(json, 'content');
    updatedAt = dateFromJson(json, 'updated_at');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other &&
          other is CustomPage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          content == other.content &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ title.hashCode ^ content.hashCode ^ updatedAt.hashCode;
}
