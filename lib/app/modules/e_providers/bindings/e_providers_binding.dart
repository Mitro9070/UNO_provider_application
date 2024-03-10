import 'package:get/get.dart';

import '../../search/controllers/search_controller.dart';
import '../controllers/e_provider_form_controller.dart';
import '../controllers/e_providers_controller.dart';

class EProvidersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EProvidersController>(
      () => EProvidersController(),
    );
    Get.lazyPut<EProviderFormController>(
      () => EProviderFormController(),
    );
    Get.lazyPut<SearchController>(
      () => SearchController(),
    );
  }
}
