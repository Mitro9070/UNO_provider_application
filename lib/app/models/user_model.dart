
import 'package:get/get.dart';
import 'package:home_services_provider/app/models/role_model.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';

import '../../common/uuid.dart';
import '../services/settings_service.dart';
import 'media_model.dart';
import 'parents/model.dart';

class User extends Model {
  String? _name;
  String? _email;
  String? _password;
  Media? _avatar;
  String? _apiToken;
  String? _deviceToken;
  String? _phoneNumber;
  bool? _verifiedPhone;
  String? _verificationId;
  String? _address;
  String? _bio;
  List<Role>? _roles;
  bool? _auth;

  User(
      {String? id,
        String? name,
        String? email,
        String? password,
        String? apiToken,
        String? deviceToken,
        String? phoneNumber,
        String? verificationId,
        String? address,
        String? bio,
        Media? avatar,
        List<Role>? roles,
        bool? auth}) {
    this.id = id;
    _auth = auth;
    _bio = bio;
    _address = address;
    _verificationId = verificationId;
    _phoneNumber = phoneNumber;
    _deviceToken = deviceToken;
    _apiToken = apiToken;
    _avatar = avatar;
    _password = password;
    _email = email;
    _roles = roles;
    _name = name;
  }

  User.fromJson(Map<String, dynamic>? json) {
    _name = stringFromJson(json, 'name');
    _email = stringFromJson(json, 'email');
    _apiToken = stringFromJson(json, 'api_token');
    _deviceToken = stringFromJson(json, 'device_token');
    _phoneNumber = stringFromJson(json, 'phone_number');
    _verifiedPhone = boolFromJson(json, 'phone_verified_at');
    _avatar = mediaFromJson(json, 'avatar');
    _roles = listFromJson(json, 'roles', (v) => Role.fromJson(v));
    _auth = boolFromJson(json, 'auth');
    try {
      _address = json?['custom_fields']['address']['view'];
    } catch (e) {
      _address = stringFromJson(json, 'address');
    }
    try {
      _bio = json?['custom_fields']['bio']['view'];
    } catch (e) {
      _bio = stringFromJson(json, 'bio');
    }
    super.fromJson(json);
  }

  String get address => _address ?? '';

  set address(String? value) {
    _address = value;
  }

  String get apiToken {
    if ((_auth ?? false)) {
      return _apiToken ?? '';
    } else {
      return '';
    }
  }

  set apiToken(String? value) {
    _apiToken = value;
  }

  bool? get auth => _auth;

  set auth(bool? value) {
    _auth = value;
  }

  Media get avatar => _avatar ?? Media();

  set avatar(Media? value) {
    _avatar = value;
  }

  String get bio => _bio ?? '';

  set bio(String? value) {
    _bio = value;
  }

  String get deviceToken => _deviceToken ?? '';

  set deviceToken(String? value) {
    _deviceToken = value;
  }

  String get email => _email ?? '';

  set email(String? value) {
    _email = value;
  }

  @override
  int get hashCode =>
      super.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      avatar.hashCode ^
      apiToken.hashCode ^
      deviceToken.hashCode ^
      phoneNumber.hashCode ^
      verifiedPhone.hashCode ^
      verificationId.hashCode ^
      address.hashCode ^
      bio.hashCode ^
      auth.hashCode;

  String get name => _name ?? '';

  set name(String? value) {
    _name = value;
  }

  String get password => _password ?? '';

  set password(String? value) {
    _password = value;
  }

  String get phoneNumber => _phoneNumber ?? '';

  set phoneNumber(String? value) {
    _phoneNumber = value;
  }

  String get verificationId => _verificationId ?? '';

  set verificationId(String? value) {
    _verificationId = value;
  }

  bool get verifiedPhone => _verifiedPhone ?? false;

  set verifiedPhone(bool value) {
    _verifiedPhone = value;
  }

  List<Role>? get roles => _roles;
  set roles(List<Role>? value) {
    _roles = value;
  }

  @override
  bool operator ==(dynamic other) =>
      super == other &&
          other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          password == other.password &&
          avatar == other.avatar &&
          apiToken == other.apiToken &&
          deviceToken == other.deviceToken &&
          phoneNumber == other.phoneNumber &&
          verifiedPhone == other.verifiedPhone &&
          verificationId == other.verificationId &&
          address == other.address &&
          bio == other.bio &&
          auth == other.auth;

  PhoneNumber getPhoneNumber() {
    if (this._phoneNumber != null && this._phoneNumber!.length > 4) {
      this.phoneNumber = this.phoneNumber.replaceAll(' ', '');
      String dialCode1 = this.phoneNumber.substring(1, 2);
      String dialCode2 = this.phoneNumber.substring(1, 3);
      String dialCode3 = this.phoneNumber.substring(1, 4);
      for (int i = 0; i < countries.length; i++) {
        if (countries[i].dialCode == dialCode1) {
          return new PhoneNumber(countryISOCode: countries[i].code, countryCode: dialCode1, number: this.phoneNumber.substring(2));
        } else if (countries[i].dialCode == dialCode2) {
          return new PhoneNumber(countryISOCode: countries[i].code, countryCode: dialCode2, number: this.phoneNumber.substring(3));
        } else if (countries[i].dialCode == dialCode3) {
          return new PhoneNumber(countryISOCode: countries[i].code, countryCode: dialCode3, number: this.phoneNumber.substring(4));
        }
      }
    }
    return new PhoneNumber(countryISOCode: Get.find<SettingsService>().setting.value.defaultCountryCode ?? '', countryCode: '1', number: '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    if (_password != null && _password != '') {
      data['password'] = this.password;
    }
    data['api_token'] = this._apiToken;
    if (_deviceToken != null) {
      data["device_token"] = deviceToken;
    }
    data["phone_number"] = phoneNumber;
    if (verifiedPhone) {
      data["phone_verified_at"] = DateTime.now().toLocal().toString();
    }
    data["address"] = address;
    data["bio"] = bio;
    if (Uuid.isUuid(avatar.id)) {
      data['avatar'] = this.avatar.id;
    }
    data["media"] = [avatar.toJson()];
    data['auth'] = this.auth;
    return data;
  }

  bool get isAdmin => (this.roles?.where((element) => element.name == 'admin').length ?? 0) > 0;

  bool get isProvider => (this.roles?.where((element) => element.name == 'provider' || element.name == 'admin').length ?? 0) > 0;

  bool get isCustomer => (this.roles?.where((element) => element.isdDefault).length ?? 0) > 0;

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["thumb"] = avatar.thumb;
    map["device_token"] = deviceToken;
    return map;
  }
}
