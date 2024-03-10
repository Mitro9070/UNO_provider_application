import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/availability_hour_model.dart';
import '../../../routes/app_routes.dart';
import '../../global_widgets/select_dialog.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/e_provider_availability_form_controller.dart';
import '../widgets/availability_hour_form_item_widget.dart';
import '../widgets/horizontal_stepper_widget.dart';
import '../widgets/step_widget.dart';

class EProviderAvailabilityFormView extends GetView<EProviderAvailabilityFormController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Provider Availability".tr,
            style: context.textTheme.titleLarge,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: ()  {
              Get.back();
            },
          ),
          elevation: 0,
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add, size: 32, color: Get.theme.primaryColor),
          onPressed: () => {controller.createAvailabilityHour()},
          backgroundColor: Get.theme.colorScheme.secondary,
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, -5)),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () async {
                    Get.offNamedUntil(Routes.E_PROVIDERS, (route) => route.settings.name == Routes.E_PROVIDERS);
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Get.theme.colorScheme.secondary,
                  child: Text("Finish".tr, style: Get.textTheme.bodyMedium?.merge(TextStyle(color: Get.theme.primaryColor))),
                  elevation: 0,
                ),
              ),
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 20),
        ),
        body: Form(
          key: controller.eProviderAvailabilityForm,
          child: ListView(
            controller: controller.scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 60),
            children: [
              HorizontalStepperWidget(
                controller: new ScrollController(initialScrollOffset: 9999),
                steps: [
                  StepWidget(
                    title: Text(
                      "Addresses".tr,
                    ),
                    color: Get.theme.focusColor,
                    index: Text("1", style: TextStyle(color: Get.theme.primaryColor)),
                  ),
                  StepWidget(
                    title: Text(
                      "Provider Details".tr,
                    ),
                    color: Get.theme.focusColor,
                    index: Text("2", style: TextStyle(color: Get.theme.primaryColor)),
                  ),
                  StepWidget(
                    title: Text(
                      "Availability".tr,
                    ),
                    index: Text("3", style: TextStyle(color: Get.theme.primaryColor)),
                  ),
                ],
              ),
              Text("Availability hours details".tr, style: Get.textTheme.headlineSmall).paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
              Text("Select your addresses".tr, style: Get.textTheme.bodySmall).paddingSymmetric(horizontal: 22, vertical: 5),
              Obx(() {
                if (controller.eProvider.value.groupedAvailabilityHours().entries.isEmpty) {
                  return SizedBox();
                }
                return Container(
                  padding: EdgeInsetsDirectional.only(top: 10, bottom: 10, end: 5, start: 20),
                  margin: EdgeInsets.all(20),
                  decoration: Ui.getBoxDecoration(),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    itemCount: controller.eProvider.value.groupedAvailabilityHours().entries.length,
                    separatorBuilder: (context, index) {
                      return Divider(height: 16, thickness: 0.8);
                    },
                    itemBuilder: (context, index) {
                      var _availabilityHour = controller.eProvider.value.groupedAvailabilityHours().entries.elementAt(index);
                      var _data = controller.eProvider.value.getAvailabilityHoursData(_availabilityHour.key);
                      return AvailabilityHourFromItemWidget(availabilityHour: _availabilityHour, data: _data);
                    },
                  ),
                );
              }),
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 10, left: 20, right: 20),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
                    ],
                    border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Days".tr,
                            style: Get.textTheme.bodyLarge,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () async {
                            final selectedValue = await showDialog<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return SelectDialog(
                                  title: "Select a day".tr,
                                  submitText: "Submit".tr,
                                  cancelText: "Cancel".tr,
                                  items: controller.getSelectDaysItems(),
                                  initialSelectedValue: controller.days.firstWhere(
                                    (element) => element == controller.availabilityHour.value.day,
                                    orElse: () => "",
                                  ),
                                );
                              },
                            );
                            controller.availabilityHour.update((val) {
                              val?.day = selectedValue;
                            });
                          },
                          shape: StadiumBorder(),
                          color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                          child: Text("Select".tr, style: Get.textTheme.titleMedium),
                          elevation: 0,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                        ),
                      ],
                    ),
                    Obx(() {
                      if (controller.availabilityHour.value.day == '') {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Select a day".tr,
                            style: Get.textTheme.bodySmall,
                          ),
                        );
                      } else {
                        return buildDays(controller.availabilityHour.value);
                      }
                    })
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 10, left: 20, right: 20),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
                    ],
                    border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Starts At".tr,
                            style: Get.textTheme.bodyLarge,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () async {
                            final picked = await Ui.showTimePickerDialog(context, controller.availabilityHour.value.startAt);
                            controller.availabilityHour.update((val) {
                              val?.startAt = picked;
                            });
                          },
                          shape: StadiumBorder(),
                          color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                          child: Text("Time Picker".tr, style: Get.textTheme.titleMedium),
                          elevation: 0,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                        ),
                      ],
                    ),
                    Obx(() {
                      if (controller.availabilityHour.value.startAt == '') {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Pick a time for starts at".tr,
                            style: Get.textTheme.bodySmall,
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            controller.availabilityHour.value.startAt,
                            style: Get.textTheme.bodyMedium,
                          ),
                        );
                      }
                    })
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 10, left: 20, right: 20),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Get.theme.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
                    ],
                    border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Ends At".tr,
                            style: Get.textTheme.bodyLarge,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () async {
                            final picked = await Ui.showTimePickerDialog(context, controller.availabilityHour.value.endAt);
                            controller.availabilityHour.update((val) {
                              val?.endAt = picked;
                            });
                          },
                          shape: StadiumBorder(),
                          color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                          child: Text("Time Picker".tr, style: Get.textTheme.titleMedium),
                          elevation: 0,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                        ),
                      ],
                    ),
                    Obx(() {
                      if (controller.availabilityHour.value.endAt == '') {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Pick a time for ends at".tr,
                            style: Get.textTheme.bodySmall,
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            controller.availabilityHour.value.endAt,
                            style: Get.textTheme.bodyMedium,
                          ),
                        );
                      }
                    })
                  ],
                ),
              ),
              Obx(() {
                return TextFieldWidget(
                  onSaved: (input) => controller.availabilityHour.value.data = input,
                  keyboardType: TextInputType.multiline,
                  initialValue: controller.availabilityHour.value.data,
                  hintText: "Notes for this availability hour".tr,
                  labelText: "Notes".tr,
                );
              }),
            ],
          ),
        ));
  }

  Widget buildDays(AvailabilityHour _availabilityHour) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Text(_availabilityHour.day.tr ?? '', style: Get.textTheme.bodyMedium),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
