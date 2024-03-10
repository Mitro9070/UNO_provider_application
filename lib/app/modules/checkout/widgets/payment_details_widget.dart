/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/e_provider_subscription_model.dart';
import '../../bookings/widgets/booking_row_widget.dart';

class PaymentDetailsWidget extends StatelessWidget {
  const PaymentDetailsWidget({
    Key? key,
    required EProviderSubscription eProviderSubscription,
  })  : _eProviderSubscription = eProviderSubscription,
        super(key: key);

  final EProviderSubscription _eProviderSubscription;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      // decoration: Ui.getBoxDecoration(),
      child: Wrap(
        runSpacing: 10,
        alignment: WrapAlignment.start,
        children: <Widget>[
          Text(
            "Subscription Package".tr,
            style: Get.textTheme.bodyMedium,
            maxLines: 3,
            // textAlign: TextAlign.end,
          ),
          Divider(height: 8, thickness: 1),
          BookingRowWidget(
            description: _eProviderSubscription.subscriptionPackage.name,
            valueStyle: Get.textTheme.bodyMedium,
            child: Align(
              alignment: Alignment.centerRight,
              child: Ui.getPrice(_eProviderSubscription.subscriptionPackage.getPrice, style: Get.textTheme.titleSmall),
            ),
          ),
        ],
      ),
    );
  }
}
