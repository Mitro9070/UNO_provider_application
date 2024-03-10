import 'parents/model.dart';

class SubscriptionPackage extends Model {

  String? _name;
  String? _description;
  double? _price;
  double? _discountPrice;
  int? _durationInDays;

  SubscriptionPackage(
      {String? id,
      String? name,
      String? description,
      double? price,
      double? discountPrice,
      int? durationInDays}) {
    _durationInDays = durationInDays;
    _discountPrice = discountPrice;
    _price = price;
    _description = description;
    _name = name;
    this.id = id;
  }

  SubscriptionPackage.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _name = transStringFromJson(json, 'name');
    _description = transStringFromJson(json, 'description');
    _price = doubleFromJson(json, 'price');
    _discountPrice = doubleFromJson(json, 'discount_price');
    _durationInDays = intFromJson(json, 'duration_in_days');
  }
  String? get name => _name ?? '';
  set name(String? value) {
    _name = value;
  }

  String? get description => _description ?? '';
  set description(String? value) {
    _description = value;
  }

  double? get price => _price ?? 0;
  set price(double? value) {
    _price = value;
  }

  double? get discountPrice => _discountPrice ?? 0;
  set discountPrice(double? value) {
    _discountPrice = value;
  }

  int? get durationInDays => _durationInDays ?? 0;
  set durationInDays(int? value) {
    _durationInDays = value;
  }


  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['duration_in_days'] = this.durationInDays;
    return data;
  }

  /*
  * Get the real price of the service
  * when the discount not set, then it return the price
  * otherwise it return the discount price instead
  * */
  double get getPrice {
    return (discountPrice ?? 0) > 0 ? discountPrice! : price!;
  }

  /*
  * Get discount price
  * */
  double get getOldPrice {
    return (discountPrice ?? 0) > 0 ? price! : 0;
  }
}
