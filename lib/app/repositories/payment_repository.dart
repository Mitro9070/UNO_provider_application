import 'package:get/get.dart';

import '../models/e_provider_subscription_model.dart';
import '../models/payment_method_model.dart';
import '../models/payment_model.dart';
import '../models/wallet_model.dart';
import '../models/wallet_transaction_model.dart';
import '../providers/laravel_provider.dart';

class PaymentRepository {
  late LaravelApiClient _laravelApiClient;

  PaymentRepository() {
    _laravelApiClient = Get.find<LaravelApiClient>();
  }

  Future<List<PaymentMethod>> getMethods() {
    return _laravelApiClient.getPaymentMethods();
  }

  Future<List<Wallet>> getWallets() {
    return _laravelApiClient.getWallets();
  }

  Future<List<WalletTransaction>> getWalletTransactions(Wallet wallet) {
    return _laravelApiClient.getWalletTransactions(wallet);
  }

  Future<Wallet> createWallet(Wallet wallet) {
    return _laravelApiClient.createWallet(wallet);
  }

  Future<Wallet> updateWallet(Wallet wallet) {
    return _laravelApiClient.updateWallet(wallet);
  }

  Future<bool> deleteWallet(Wallet wallet) {
    return _laravelApiClient.deleteWallet(wallet);
  }

  Future<Payment> update(Payment payment) {
    return _laravelApiClient.updatePayment(payment);
  }

  Uri getPayPalUrl(EProviderSubscription eProviderSubscription) {
    return _laravelApiClient.getPayPalUrl(eProviderSubscription);
  }

  Uri getRazorPayUrl(EProviderSubscription eProviderSubscription) {
    return _laravelApiClient.getRazorPayUrl(eProviderSubscription);
  }

  Uri getStripeUrl(EProviderSubscription eProviderSubscription) {
    return _laravelApiClient.getStripeUrl(eProviderSubscription);
  }

  Uri getPayStackUrl(EProviderSubscription eProviderSubscription) {
    return _laravelApiClient.getPayStackUrl(eProviderSubscription);
  }

  Uri getPayMongoUrl(EProviderSubscription eProviderSubscription) {
    return _laravelApiClient.getPayMongoUrl(eProviderSubscription);
  }

  Uri getFlutterWaveUrl(EProviderSubscription eProviderSubscription) {
    return _laravelApiClient.getFlutterWaveUrl(eProviderSubscription);
  }

  Uri getStripeFPXUrl(EProviderSubscription eProviderSubscription) {
    return _laravelApiClient.getStripeFPXUrl(eProviderSubscription);
  }
}
