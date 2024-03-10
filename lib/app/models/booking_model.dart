import 'address_model.dart';
import 'booking_status_model.dart';
import 'coupon_model.dart';
import 'e_provider_model.dart';
import 'e_service_model.dart';
import 'option_model.dart';
import 'parents/model.dart';
import 'payment_model.dart';
import 'tax_model.dart';
import 'user_model.dart';

class Booking extends Model {
  String? _hint;

  bool? _cancel;

  double? _duration;

  int? _quantity;

  BookingStatus? _status;

  User? _user;

  EService? _eService;

  EProvider? _eProvider;

  List<Option>? _options;

  List<Tax>? _taxes;

  Address? _address;

  Coupon? _coupon;

  DateTime? _bookingAt;

  DateTime? _startAt;

  DateTime? _endsAt;

  Payment? _payment;

  Booking(
      {String? id,
        String? hint,
        bool? cancel,
        double? duration = 0,
        int? quantity = 1,
        BookingStatus? status,
        User? user,
        EService? eService,
        EProvider? eProvider,
        List<Option>? options,
        List<Tax>? taxes,
        Address? address,
        Coupon? coupon,
        DateTime? bookingAt,
        DateTime? startAt,
        DateTime? endsAt,
        Payment? payment}) {
    this.id = id;
    _payment = payment;
    _endsAt = endsAt;
    _startAt = startAt;
    _bookingAt = bookingAt;
    _coupon = coupon;
    _address = address;
    _taxes = taxes;
    _options = options;
    _eProvider = eProvider;
    _eService = eService;
    _user = user;
    _status = status;
    _quantity = quantity;
    _duration = duration;
    _cancel = cancel;
    _hint = hint;
  }

  Booking.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _hint = stringFromJson(json, 'hint');
    _cancel = boolFromJson(json, 'cancel');
    _duration = doubleFromJson(json, 'duration');
    _quantity = intFromJson(json, 'quantity');
    _status = objectFromJson(json, 'booking_status', (v) => BookingStatus.fromJson(v));
    _user = objectFromJson(json, 'user', (v) => User.fromJson(v));
    _eService = objectFromJson(json, 'e_service', (v) => EService.fromJson(v));
    _eProvider = objectFromJson(json, 'e_provider', (v) => EProvider.fromJson(v));
    _address = objectFromJson(json, 'address', (v) => Address.fromJson(v));
    _coupon = objectFromJson(json, 'coupon', (v) => Coupon.fromJson(v));
    _payment = objectFromJson(json, 'payment', (v) => Payment.fromJson(v));
    _options = listFromJson(json, 'options', (v) => Option.fromJson(v));
    _taxes = listFromJson(json, 'taxes', (v) => Tax.fromJson(v));
    _bookingAt = dateFromJson(json, 'booking_at', defaultValue: null);
    _startAt = dateFromJson(json, 'start_at', defaultValue: null);
    _endsAt = dateFromJson(json, 'ends_at', defaultValue: null);
  }

  Address get address => _address ?? new Address();

  set address(Address? value) {
    _address = value;
  }

  DateTime? get bookingAt => _bookingAt;

  set bookingAt(DateTime? value) {
    _bookingAt = value;
  }

  bool get cancel => _cancel ?? false;

  set cancel(bool? value) {
    _cancel = value;
  }

  Coupon get coupon => _coupon ?? new Coupon();

  set coupon(Coupon? value) {
    _coupon = value;
  }

  double get duration => _duration ?? 0;

  set duration(double? value) {
    _duration = value;
  }

  DateTime? get endsAt => _endsAt;

  set endsAt(DateTime? value) {
    _endsAt = value;
  }

  EProvider get eProvider => _eProvider ?? new EProvider();

  set eProvider(EProvider? value) {
    _eProvider = value;
  }

  EService get eService => _eService ?? new EService();

  set eService(EService? value) {
    _eService = value;
  }

  @override
  int get hashCode =>
      super.hashCode ^
      id.hashCode ^
      hint.hashCode ^
      cancel.hashCode ^
      duration.hashCode ^
      quantity.hashCode ^
      status.hashCode ^
      user.hashCode ^
      eService.hashCode ^
      eProvider.hashCode ^
      options.hashCode ^
      taxes.hashCode ^
      address.hashCode ^
      coupon.hashCode ^
      bookingAt.hashCode ^
      startAt.hashCode ^
      endsAt.hashCode ^
      payment.hashCode;

  String get hint => _hint ?? '';

  set hint(String? value) {
    _hint = value;
  }

  List<Option> get options => _options ?? [];

  set options(List<Option>? value) {
    _options = value;
  }

  Payment? get payment => _payment;

  set payment(Payment? value) {
    _payment = value;
  }

  int get quantity => _quantity ?? 1;

  set quantity(int? value) {
    _quantity = value;
  }

  DateTime? get startAt => _startAt;

  set startAt(DateTime? value) {
    _startAt = value;
  }

  BookingStatus get status => _status ?? new BookingStatus();

  set status(BookingStatus? value) {
    _status = value;
  }

  List<Tax> get taxes => _taxes ?? [];

  set taxes(List<Tax>? value) {
    _taxes = value;
  }

  User get user => _user ?? new User();

  set user(User? value) {
    _user = value;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
          super == other &&
              other is Booking &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              hint == other.hint &&
              cancel == other.cancel &&
              duration == other.duration &&
              quantity == other.quantity &&
              status == other.status &&
              user == other.user &&
              eService == other.eService &&
              eProvider == other.eProvider &&
              options == other.options &&
              taxes == other.taxes &&
              address == other.address &&
              coupon == other.coupon &&
              bookingAt == other.bookingAt &&
              startAt == other.startAt &&
              endsAt == other.endsAt &&
              payment == other.payment;

  double getCouponValue() {
    double total = getSubtotal();
    if (!coupon.hasData) {
      return 0;
    } else {
      if (coupon.discountType == 'percent') {
        return -(total * coupon.discount / 100);
      } else {
        return -coupon.discount;
      }
    }
  }

  double getSubtotal() {
    double total = 0.0;
    if (eService.priceUnit == 'fixed') {
      total = eService.getPrice * (quantity >= 1 ? quantity : 1);
      options.forEach((element) {
        total += element.price * (quantity >= 1 ? quantity : 1);
      });
    } else {
      total = eService.getPrice * duration;
      options.forEach((element) {
        total += element.price;
      });
    }
    return total;
  }

  double getTaxesValue() {
    double total = getSubtotal();
    double taxValue = 0.0;
    taxes.forEach((element) {
      if (element.type == 'percent') {
        taxValue += (total * element.value / 100);
      } else {
        taxValue += element.value;
      }
    });
    return taxValue;
  }

  double getTotal() {
    double total = getSubtotal();
    total += getTaxesValue();
    total += getCouponValue();
    return total;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.hasData) {
      data['id'] = this.id;
    }
    if (this._hint != null) {
      data['hint'] = this.hint;
    }
    data['duration'] = this.duration;
    data['quantity'] = this.quantity;
    if (this._cancel != null) {
      data['cancel'] = this.cancel;
    }
    if (this._status != null) {
      data['booking_status_id'] = this.status.id;
    }
    if (this._coupon != null && this._coupon?.code != null) {
      data['coupon'] = this.coupon.toJson();
    }
    if (this._coupon != null && this.coupon.hasData) {
      data['coupon_id'] = this.coupon.id;
    }
    if (this._taxes != null) {
      data['taxes'] = this.taxes.map((e) => e.toJson()).toList();
    }
    if (this._options != null && this.options.isNotEmpty) {
      data['options'] = this.options.map((e) => e.id).toList();
    }
    if (this._user != null) {
      data['user_id'] = this.user.id;
    }
    if (this._address != null) {
      data['address'] = this.address.toJson();
    }
    if (this._eService != null) {
      data['e_service'] = this.eService.id;
    }
    if (this._eProvider != null) {
      data['e_provider'] = this.eProvider.toJson();
    }
    if (this._payment != null) {
      data['payment'] = this._payment!.toJson();
    }
    if (this._bookingAt != null) {
      data['booking_at'] = bookingAt!.toUtc().toString();
    }
    if (this._startAt != null) {
      data['start_at'] = startAt!.toUtc().toString();
    }
    if (this._endsAt != null) {
      data['ends_at'] = endsAt!.toUtc().toString();
    }
    return data;
  }
}
