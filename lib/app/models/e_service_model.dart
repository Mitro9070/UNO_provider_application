import 'package:get/get.dart';

import 'category_model.dart';
import 'e_provider_model.dart';
import 'media_model.dart';
import 'parents/model.dart';

class EService extends Model {
  String? _name;
  String? _description;
  List<Media>? _images;
  double? _price;
  double? _discountPrice;
  String? _priceUnit;
  String? _quantityUnit;
  double? _rate;
  int? _totalReviews;
  String? _duration;
  bool? _featured;
  bool? _enableBooking;
  bool? _isFavorite;
  List<Category>? _categories;
  List<Category>? _subCategories;
  EProvider? _eProvider;

  EService(
      {String? id,
        String? name,
        String? description,
        double? price,
        double? discountPrice,
        String? priceUnit,
        String? quantityUnit,
        double? rate,
        int? totalReviews,
        String? duration,
        bool? featured,
        bool? enableBooking,
        bool? isFavorite,
        List<Category>? categories,
        List<Category>? subCategories,
        EProvider? eProvider}) {
    this.id = id;
    _duration = duration;
    _categories = categories;
    _eProvider = eProvider;
    _subCategories = subCategories;
    _isFavorite = isFavorite;
    _enableBooking = enableBooking;
    _featured = featured;
    _totalReviews = totalReviews;
    _rate = rate;
    _quantityUnit = quantityUnit;
    _priceUnit = priceUnit;
    _discountPrice = discountPrice;
    _price = price;
    _description = description;
    _name = name;
  }

  EService.fromJson(Map<String, dynamic>? json) {
    _name = transStringFromJson(json, 'name');
    _description = transStringFromJson(json, 'description');
    _images = mediaListFromJson(json, 'images');
    _price = doubleFromJson(json, 'price');
    _discountPrice = doubleFromJson(json, 'discount_price');
    _priceUnit = stringFromJson(json, 'price_unit');
    _quantityUnit = transStringFromJson(json, 'quantity_unit');
    _rate = doubleFromJson(json, 'rate');
    _totalReviews = intFromJson(json, 'total_reviews');
    _duration = stringFromJson(json, 'duration');
    _featured = boolFromJson(json, 'featured');
    _enableBooking = boolFromJson(json, 'enable_booking');
    _isFavorite = boolFromJson(json, 'is_favorite');
    _categories = listFromJson<Category>(json, 'categories', (value) => Category.fromJson(value));
    _subCategories = listFromJson<Category>(json, 'sub_categories', (value) => Category.fromJson(value));
    _eProvider = objectFromJson(json, 'e_provider', (value) => EProvider.fromJson(value));
    super.fromJson(json);
  }

  List<Category> get categories => _categories ?? [];

  set categories(List<Category>? value) {
    _categories = value;
  }

  String get description => _description ?? '';

  set description(String? value) {
    _description = value;
  }

  double get discountPrice => _discountPrice ?? 0;

  set discountPrice(double? value) {
    _discountPrice = value;
  }

  String get duration => _duration ?? '';

  set duration(String? value) {
    _duration = value;
  }

  bool get enableBooking => _enableBooking ?? true;

  set enableBooking(bool? value) {
    _enableBooking = value;
  }

  EProvider get eProvider => _eProvider ?? EProvider();

  set eProvider(EProvider? value) {
    _eProvider = value;
  }

  bool get featured => _featured ?? false;

  set featured(bool? value) {
    _featured = value;
  }

  String get firstImageIcon => this.images.first.icon;

  String get firstImageThumb => this.images.first.thumb;

  String get firstImageUrl => this.images.first.url;

  /*
  * Get discount price
  * */
  double get getOldPrice {
    return (discountPrice) > 0 ? price : 0;
  }

  /*
  * Get the real price of the service
  * when the discount not set, then it return the price
  * otherwise it return the discount price instead
  * */
  double get getPrice {
    return (discountPrice) > 0 ? discountPrice : price;
  }

  String get getUnit {
    if (priceUnit == 'fixed') {
      if (quantityUnit.isNotEmpty) {
        return "/" + quantityUnit.tr;
      } else {
        return "";
      }
    } else {
      return "/h".tr;
    }
  }

  @override
  bool get hasData {
    return super.hasData && _name != null && _description != null;
  }

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      rate.hashCode ^
      eProvider.hashCode ^
      categories.hashCode ^
      subCategories.hashCode ^
      isFavorite.hashCode ^
      enableBooking.hashCode;

  List<Media> get images => _images ?? [];

  set images(List<Media> value) {
    _images = value;
  }

  bool get isFavorite => _isFavorite ?? false;

  set isFavorite(bool? value) {
    _isFavorite = value;
  }

  String get name => _name ?? '';

  set name(String? value) {
    _name = value;
  }

  double get price => _price ?? 0;

  set price(double? value) {
    _price = value;
  }

  String get priceUnit => _priceUnit ?? '';

  set priceUnit(String? value) {
    _priceUnit = value;
  }

  String get quantityUnit => _quantityUnit ?? '';

  set quantityUnit(String? value) {
    _quantityUnit = value;
  }

  double get rate => _rate ?? 0;

  set rate(double? value) {
    _rate = value;
  }

  List<Category> get subCategories => _subCategories ?? [];

  set subCategories(List<Category>? value) {
    _subCategories = value;
  }

  int get totalReviews => _totalReviews ?? 0;

  set totalReviews(int? value) {
    _totalReviews = value;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
          super == other &&
              other is EService &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              description == other.description &&
              rate == other.rate &&
              isFavorite == other.isFavorite &&
              enableBooking == other.enableBooking &&
              categories == other.categories &&
              subCategories == other.subCategories &&
              eProvider == other.eProvider;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.hasData) data['id'] = this.id;
    if (_name != null) data['name'] = this.name;
    if (this._description != null) data['description'] = this.description;
    if (this._price != null) data['price'] = this.price;
    if (_discountPrice != null) data['discount_price'] = this.discountPrice;
    if (_priceUnit != null) data['price_unit'] = this.priceUnit;
    if (_quantityUnit != null && quantityUnit != 'null') data['quantity_unit'] = this.quantityUnit;
    if (_rate != null) data['rate'] = this.rate;
    if (_totalReviews != null) data['total_reviews'] = this.totalReviews;
    if (_duration != null) data['duration'] = this.duration;
    if (_featured != null) data['featured'] = this.featured;
    if (_enableBooking != null) data['enable_booking'] = this.enableBooking;
    if (_isFavorite != null) data['is_favorite'] = this.isFavorite;
    if (this._categories != null) {
      data['categories'] = this.categories.map((v) => v.id).toList();
    }
    data['image'] = this.images.map((v) => v.toJson()).toList();
    if (this._subCategories != null) {
      data['sub_categories'] = this.subCategories.map((v) => v.toJson()).toList();
    }
    if (this._eProvider != null && this.eProvider.hasData) {
      data['e_provider_id'] = this.eProvider.id;
    }
    return data;
  }
}
