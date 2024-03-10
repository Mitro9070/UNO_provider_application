/*
 * Copyright (c) 2020 .
 */

import 'dart:core';

import 'e_provider_model.dart';
import 'parents/model.dart';
import 'payment_model.dart';
import 'subscription_package_model.dart';

class EProviderSubscription extends Model {

  EProvider? _eProvider;
  SubscriptionPackage? _subscriptionPackage;
  DateTime? _startsAt;
  DateTime? _expiresAt;
  Payment? _payment;
  bool? _active;

  EProviderSubscription(
      {String? id,
      EProvider? eProvider,
      SubscriptionPackage? subscriptionPackage,
      DateTime? startsAt,
      DateTime? expiresAt,
      Payment? payment,
      bool? active}) {
    _active = active;
    _payment = payment;
    _expiresAt = expiresAt;
    _startsAt = startsAt;
    _subscriptionPackage = subscriptionPackage;
    _eProvider = eProvider;
    this.id = id;
  }

  EProviderSubscription.fromJson(Map<String, dynamic>? json) {
    super.fromJson(json);
    _eProvider = objectFromJson(json, 'e_provider', (value) => EProvider.fromJson(value));
    _subscriptionPackage = objectFromJson(json, 'subscription_package', (value) => SubscriptionPackage.fromJson(value));
    _startsAt = dateFromJson(json, 'starts_at', defaultValue: null);
    _expiresAt = dateFromJson(json, 'expires_at', defaultValue: null);
    _payment = objectFromJson(json, 'payment', (value) => Payment.fromJson(value));
    _active = boolFromJson(json, 'active');
  }
  EProvider get eProvider => _eProvider ?? EProvider();
  set eProvider(EProvider? value) {
    _eProvider = value;
  }

  SubscriptionPackage get subscriptionPackage => _subscriptionPackage ?? SubscriptionPackage();
  set subscriptionPackage(SubscriptionPackage? value) {
    _subscriptionPackage = value;
  }

  DateTime get startsAt => _startsAt ?? DateTime.now().toLocal();
  set startsAt(DateTime? value) {
    _startsAt = value;
  }

  DateTime get expiresAt => _expiresAt ?? DateTime.now().toLocal();
  set expiresAt(DateTime? value) {
    _expiresAt = value;
  }

  Payment get payment => _payment ?? Payment();
  set payment(Payment? value) {
    _payment = value;
  }

  bool get active => _active ?? false;
  set active(bool? value) {
    _active = value;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    if (this.eProvider != null && this.eProvider.hasData) {
      data['e_provider_id'] = this.eProvider.id;
    }
    if (this.subscriptionPackage != null && this.subscriptionPackage.hasData) {
      data['subscription_package_id'] = this.subscriptionPackage.id;
    }
    if (this.startsAt != null) {
      data['starts_at'] = startsAt.toUtc().toString();
    }
    if (this.expiresAt != null) {
      data['expires_at'] = expiresAt.toUtc().toString();
    }
    if (this.payment != null) {
      data['payment'] = this.payment.toJson();
    }
    if (this.active != null) {
      data['active'] = active;
    }
    return data;
  }
}
