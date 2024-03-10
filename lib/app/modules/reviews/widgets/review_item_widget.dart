import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/review_model.dart';
import '../../../routes/app_routes.dart';

class ReviewItemWidget extends StatelessWidget {
  final Review review;

  ReviewItemWidget({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.REVIEW, arguments: this.review);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: Ui.getBoxDecoration(),
        child: Wrap(
          runSpacing: 15,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Text(
                    review.eService.name,
                    style: Get.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: 26,
                  child: Chip(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    label: Text(review.eService.totalReviews.toString(), style: Get.textTheme.bodyLarge?.merge(TextStyle(height: 0.6))),
                    backgroundColor: Get.theme.focusColor.withOpacity(0.2),
                    shape: StadiumBorder(),
                  ),
                ),
              ],
            ),
            Divider(height: 0, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    height: 65,
                    width: 65,
                    fit: BoxFit.cover,
                    imageUrl: review.user.avatar.thumb,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      height: 65,
                      width: 65,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error_outline),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        review.user.name,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 2,
                        style: Get.textTheme.bodyMedium?.merge(TextStyle(color: Get.theme.hintColor)),
                      ),
                      Text(
                        review.user.bio,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                  child: Chip(
                    padding: EdgeInsets.all(0),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(review.rate.toString(), style: Get.textTheme.bodyLarge?.merge(TextStyle(color: Get.theme.primaryColor))),
                        Icon(
                          Icons.star_border,
                          color: Get.theme.primaryColor,
                          size: 16,
                        ),
                      ],
                    ),
                    backgroundColor: Get.theme.colorScheme.secondary.withOpacity(0.9),
                    shape: StadiumBorder(),
                  ),
                ),
              ],
            ),
            Ui.removeHtml(review.review, style: Get.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
