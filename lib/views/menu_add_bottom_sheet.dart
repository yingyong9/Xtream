import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:xstream/pages/review_page.dart';
import 'package:xstream/pages/watch_live_video.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_gf_button.dart';
import 'package:xstream/views/widget_icon_button.dart';
import 'package:xstream/views/widget_text.dart';

class MenuAddBottomSheet extends StatelessWidget {
  const MenuAddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      // heightFactor: 0.25,
      child: Container(
        margin: EdgeInsets.zero,
        decoration: const BoxDecoration(
          color: ColorPlate.back1,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 8),
          children: [
            WidgetGfButton(
              label: 'Video',
              pressFunc: () {
                Get.back();
                AppService().processUploadVideoFromGallery();
              },
              fullScreen: true,
              gfButtonType: GFButtonType.outline2x,
              textColor: Colors.white,
              color: Colors.white,
            ),
            WidgetGfButton(
              label: 'Travel',
              pressFunc: () {
                Get.back();
                 Get.to(ReviewPage(indexReviewCat: 1));
              },
              fullScreen: true,
              gfButtonType: GFButtonType.outline2x,
              textColor: Colors.white,
              color: Colors.white,
            ),
            WidgetGfButton(
              label: 'Hotel',
              pressFunc: () {
                Get.back();
                 Get.to(ReviewPage(indexReviewCat: 2));
              },
              fullScreen: true,
              gfButtonType: GFButtonType.outline2x,
              textColor: Colors.white,
              color: Colors.white,
            ),
            WidgetGfButton(
              label: 'Food',
              pressFunc: () {
                Get.back();
                Get.to(ReviewPage(indexReviewCat: 0));
              },
              fullScreen: true,
              gfButtonType: GFButtonType.outline2x,
              textColor: Colors.white,
              color: Colors.white,
            ),
            WidgetGfButton(
              label: 'Other',
              pressFunc: () {
                Get.back();
                 Get.to(ReviewPage(indexReviewCat: 3));
              },
              fullScreen: true,
              gfButtonType: GFButtonType.outline2x,
              textColor: Colors.white,
              color: Colors.white,
            ),
            WidgetGfButton(
              label: 'สร้างร้านค้า',
              pressFunc: () {
                Get.back();
              },
              fullScreen: true,
              gfButtonType: GFButtonType.outline2x,
              textColor: Colors.white,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
