import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../services/global_service.dart';

class PrivacyController extends GetxController {
  late WebViewController webView;

  @override
  void onInit() {
    webView = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("${Get.find<GlobalService>().baseUrl}privacy/index.html"));
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.onInit();
  }
}
