import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../common/helper.dart';
import '../../../models/booking_model.dart';
import '../../../models/e_provider_subscription_model.dart';
import '../../../repositories/payment_repository.dart';
import '../../../routes/app_routes.dart';
import '../../../services/global_service.dart';
import '../../global_widgets/tab_bar_widget.dart';

class FlutterWaveController extends GetxController {
  late WebViewController webView;
  late PaymentRepository _paymentRepository;
  final url = Uri().obs;
  final progress = 0.0.obs;
  final eProviderSubscription = new EProviderSubscription().obs;

  FlutterWaveController() {
    _paymentRepository = new PaymentRepository();
  }

  @override
  void onInit() {
    eProviderSubscription.value = Get.arguments['eProviderSubscription'] as EProviderSubscription;
    getUrl();
    initWebView();
    super.onInit();
  }

  void initWebView() {
    webView = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(url.value)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String _url) {
            url.value = Uri.parse(_url);
            showConfirmationIfSuccess();
          },
          onPageFinished: (String url) {
            progress.value = 1;
          },
        ),
      );
  }

  void getUrl() {
    url.value = _paymentRepository.getFlutterWaveUrl(eProviderSubscription.value);
  }

  void showConfirmationIfSuccess() {
    final _doneUrl = "${Helper.toUrl(Get.find<GlobalService>().baseUrl)}subscription/payments/flutterwave";
    if (url.value.toString() == _doneUrl) {
      Get.toNamed(Routes.CONFIRMATION, arguments: {
        'title': "Payment Successful".tr,
        'long_message': "Your Payment is Successful".tr,
      });
    }
  }
}
