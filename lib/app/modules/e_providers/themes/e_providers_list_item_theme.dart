/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/cupertino.dart';

import '../widgets/e_providers_list_item_widget.dart';

extension EProvidersListItemTheme on EProvidersListItemWidget {
  BoxDecoration containerBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(0)),
      boxShadow: [
        //BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
      ],
    );
  }
}
