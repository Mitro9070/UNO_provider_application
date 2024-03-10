import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../../../common/ui.dart';
import '../../../models/e_provider_subscription_model.dart';

class SubscriptionItemWidget extends StatelessWidget {
  final EProviderSubscription subscription;

  SubscriptionItemWidget({Key? key, required this.subscription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: Ui.getBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            this.subscription.eProvider.name,
            style: Get.textTheme.bodyMedium,
          ),
          Divider(
            height: 30,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(text: "Starts At".tr, style: Get.textTheme.bodyLarge, children: <TextSpan>[
                      TextSpan(
                        text: DateFormat('  d, MMMM y  HH:mm', Get.locale.toString()).format(subscription.startsAt),
                        style: Get.textTheme.bodySmall,
                      ),
                    ]),
                  ),
                  RichText(
                    text: TextSpan(text: "Expires At".tr, style: Get.textTheme.bodyLarge, children: <TextSpan>[
                      TextSpan(
                        text: DateFormat('  d, MMMM y  HH:mm', Get.locale.toString()).format(subscription.expiresAt),
                        style: Get.textTheme.bodySmall,
                      ),
                    ]),
                  ),
                ],
              ),
              if (subscription.active)
                Container(
                  child: Text("Enabled".tr,
                      maxLines: 1,
                      style: Get.textTheme.bodyMedium?.merge(
                        TextStyle(color: Colors.green),
                      ),
                      softWrap: false,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                ),
              if (!subscription.active)
                Container(
                  child: Text("Disabled".tr,
                      maxLines: 1,
                      style: Get.textTheme.bodyMedium?.merge(
                        TextStyle(color: Colors.grey),
                      ),
                      softWrap: false,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Payment Method".tr,
                  style: Get.textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Text(
                  subscription.payment.paymentMethod.name,
                  style: Get.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  subscription.subscriptionPackage.name ?? '',
                  style: Get.textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!subscription.payment.hasData)
                Ui.getPrice(
                  subscription.payment.amount,
                  style: Get.textTheme.titleLarge,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
