import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/e_provider_model.dart';
import '../../../repositories/e_provider_repository.dart';

enum EProviderFilter { ALL, ACCEPTED, PENDING, FEATURED }

class EProvidersController extends GetxController {
  final selected = Rx<EProviderFilter>(EProviderFilter.ALL);
  final eProviders = <EProvider>[].obs;
  final page = 0.obs;
  final isLoading = true.obs;
  final isDone = false.obs;

  late EProviderRepository _eProviderRepository;
  ScrollController scrollController = ScrollController();

  EProvidersController() {
    _eProviderRepository = new EProviderRepository();
  }

  @override
  Future<void> onInit() async {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value) {
        loadEProvidersOfFilter(filter: selected.value);
      }
    });
    await refreshEProviders();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future refreshEProviders({bool? showMessage}) async {
    toggleSelected(selected.value);
    await loadEProvidersOfFilter(filter: selected.value);
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "List of services refreshed successfully".tr));
    }
  }

  bool isSelected(EProviderFilter filter) => selected == filter;

  void toggleSelected(EProviderFilter filter) async {
    this.eProviders.clear();
    this.page.value = 0;
    if (isSelected(filter)) {
      selected.value = EProviderFilter.ALL;
    } else {
      selected.value = filter;
    }
  }

  Future loadEProvidersOfFilter({EProviderFilter? filter}) async {
    try {
      isLoading.value = true;
      isDone.value = false;
      this.page.value++;
      List<EProvider> _eProviders = [];
      switch (filter) {
        case EProviderFilter.ALL:
          _eProviders = await _eProviderRepository.getEProviders(page: this.page.value);
          break;
        case EProviderFilter.ACCEPTED:
          _eProviders = await _eProviderRepository.getAcceptedEProviders(page: this.page.value);
          break;
        case EProviderFilter.FEATURED:
          _eProviders = await _eProviderRepository.getFeaturedEProviders(page: this.page.value);
          break;
        case EProviderFilter.PENDING:
          _eProviders = await _eProviderRepository.getPendingEProviders(page: this.page.value);
          break;
        default:
          _eProviders = await _eProviderRepository.getEProviders(page: this.page.value);
      }
      if (_eProviders.isNotEmpty) {
        this.eProviders.addAll(_eProviders);
      } else {
        isDone.value = true;
      }
    } catch (e) {
      this.isDone.value = true;
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoading.value = false;
    }
  }

  void deleteEProvider(EProvider eProvider) async {
    try {
      await _eProviderRepository.delete(eProvider);
      eProviders.remove(eProvider);
      Get.showSnackbar(Ui.SuccessSnackBar(message: eProvider.name + " " + "has been removed".tr));
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
