import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/e_provider_subscription_model.dart';
import '../../../models/wallet_model.dart';
import '../../../repositories/subscription_repository.dart';

class WalletController extends GetxController {
  final eProviderSubscription = new EProviderSubscription().obs;
  final wallet = new Wallet().obs;

  late SubscriptionRepository _subscriptionRepository;

  WalletController() {
    _subscriptionRepository = new SubscriptionRepository();
  }

  @override
  void onInit() {
    eProviderSubscription.value = Get.arguments['eProviderSubscription'] as EProviderSubscription;
    wallet.value = Get.arguments['wallet'] as Wallet;
    paySubscription();
    super.onInit();
  }

  Future paySubscription() async {
    try {
      eProviderSubscription.value = await _subscriptionRepository.walletEProviderSubscription(eProviderSubscription.value, wallet.value);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  bool isLoading() {
    if (eProviderSubscription.value != null && !eProviderSubscription.value.hasData) {
      return true;
    }
    return false;
  }

  bool isDone() {
    if (eProviderSubscription.value != null && eProviderSubscription.value.hasData) {
      return true;
    }
    return false;
  }

  bool isFailed() {
    if (eProviderSubscription.value == null) {
      return true;
    }
    return false;
  }
}
