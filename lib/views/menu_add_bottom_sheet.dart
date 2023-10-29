import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:xstream/pages/review_page2.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_gf_button.dart';

class MenuAddBottomSheet extends StatefulWidget {
  const MenuAddBottomSheet({super.key});

  @override
  State<MenuAddBottomSheet> createState() => _MenuAddBottomSheetState();
}

class _MenuAddBottomSheetState extends State<MenuAddBottomSheet> {
  AppController appController = Get.put(AppController());

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
              label: 'Review',
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
              label: 'นักสำรวจสถานที่ท่องเที่ยว',
              pressFunc: () {
                Get.back();
                Get.to(ReviewPage2(indexReviewCat: 1));
              },
              fullScreen: true,
              gfButtonType: GFButtonType.outline2x,
              textColor: Colors.white,
              color: Colors.white,
            ),
            WidgetGfButton(
              label: 'นักสำรวจ Hotel',
              pressFunc: () {
                Get.back();
                Get.to(ReviewPage2(indexReviewCat: 2))?.then((value) {});
              },
              fullScreen: true,
              gfButtonType: GFButtonType.outline2x,
              textColor: Colors.white,
              color: Colors.white,
            ),
            WidgetGfButton(
              label: 'นักสำรวจ Food',
              pressFunc: () {
                Get.back();
                Get.to(const ReviewPage2(indexReviewCat: 0))?.then((value) {
                  Map<String, dynamic> map = value;
                  print('##26oct map ที่ได้จาก reviewPost ----> $map');

                 
                });
              },
              fullScreen: true,
              gfButtonType: GFButtonType.outline2x,
              textColor: Colors.white,
              color: Colors.white,
            ),
            WidgetGfButton(
              label: 'นักสำรวจทุกอย่าง',
              pressFunc: () {
                Get.back();
                Get.to(const ReviewPage2(indexReviewCat: 3));
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
