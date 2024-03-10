import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/media_model.dart';
import '../../global_widgets/image_field_widget.dart';
import '../../global_widgets/select_dialog.dart';
import '../../global_widgets/text_field_widget.dart';
import '../controllers/documents_controller.dart';

class DocumentsView extends GetView<DocumentsController> {
  final bool hideAppBar;

  DocumentsView({this.hideAppBar = false});

  @override
  Widget build(BuildContext context) {
    controller.profileForm = new GlobalKey<FormState>();
    return Scaffold(
        appBar: hideAppBar
            ? null
            : AppBar(
                title: Text(
                  "Documents".tr,
                  style: context.textTheme.headline6,
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
                  onPressed: () => Get.back(),
                ),
                elevation: 0,
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
                  onPressed: () {
                    controller.saveProfileForm();
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Get.theme.colorScheme.secondary,
                  child: Text("Save".tr, style: Get.textTheme.bodyMedium?.merge(TextStyle(color: Get.theme.primaryColor))),
                  elevation: 0,
                  highlightElevation: 0,
                  hoverElevation: 0,
                  focusElevation: 0,
                ),
              ),
              SizedBox(width: 10),
              MaterialButton(
                onPressed: () {
                  controller.resetProfileForm();
                },
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Get.theme.hintColor.withOpacity(0.1),
                child: Text("Reset".tr, style: Get.textTheme.bodyText2),
                elevation: 0,
                highlightElevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
              ),
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 20),
        ),
        body: Form(
          key: controller.profileForm,
          child: ListView(
            primary: true,
            children: [
              Text("Profile details".tr, style: Get.textTheme.headline5).paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
              Text("Change the following details and save them".tr, style: Get.textTheme.caption).paddingSymmetric(horizontal: 22, vertical: 5),
              Obx(() {
                return ImageFieldWidget(
                  label: "Documents".tr,
                  field: 'document',
                  tag: controller.profileForm.hashCode.toString(),
                  initialImage: controller.avatar.value,
                  uploadCompleted: (uuid) {
                    controller.avatar.value = new Media(id: uuid);
                  },
                  reset: (uuid) {
                    controller.avatar.value = new Media(thumb: controller.user.value.avatar.thumb);
                  },
                );
              }),
              TextFieldWidget(
                onSaved: (input) => controller.user.value.name = input,
                validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
                initialValue: controller.user.value.name,
                hintText: "John Doe".tr,
                labelText: "Full Name".tr,
                iconData: Icons.person_outline,
              ),
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 10, left: 20, right: 20),
                margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
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
                            "Provider Types".tr,
                            style: Get.textTheme.bodyText1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () async {
                            final selectedValue = await showDialog<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return SelectDialog(
                                  title: "Select Provider Type".tr,
                                  submitText: "Submit".tr,
                                  cancelText: "Cancel".tr,
                                  items: controller.getSelectDocumentTypesItems(),
                                  initialSelectedValue: controller.documentTypes.firstWhere(
                                    (element) => element == "", //controller.document.value.type,
                                    orElse: () => "",
                                  ),
                                );
                              },
                            );
/*                            controller.document.update((val) {
                              val.type = selectedValue;
                            });*/
                          },
                          shape: StadiumBorder(),
                          color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                          child: Text("Select".tr, style: Get.textTheme.subtitle1),
                          elevation: 0,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                        ),
                      ],
                    ),
/*                    Obx(() {
                      if (controller.eProvider.value?.type == null) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Select providers".tr,
                            style: Get.textTheme.caption,
                          ),
                        );
                      } else {
                        return buildProviderType(controller.eProvider.value);
                      }
                    })*/
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
