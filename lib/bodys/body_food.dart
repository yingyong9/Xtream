// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/utility/app_controller.dart';

import 'package:xstream/views/widget_ratting.dart';

class BodyFood extends StatefulWidget {
  const BodyFood({super.key});

  @override
  State<BodyFood> createState() => _BodyFoodState();
}

class _BodyFoodState extends State<BodyFood> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print('map[] ---> ${appController.foodSum}');
      return Column(
        children: [
          WidgetRatingStar(
            title: 'โดยรวม',
            sizeIcon: 30,
            map: appController.foodSum,
            ratingUpdateFunc: (double rating) {
              appController.foodSum['โดยรวม'] = rating;
            },
          ),
          WidgetRatingStar(
            title: 'รสชาติ',
            map: appController.foodItem1,
            ratingUpdateFunc: (double rating) {
              appController.foodItem1['รสชาติ'] = rating;
            },
          ),
          WidgetRatingStar(
            title: 'สิ่งแวดล้อม',
            map: appController.foodItem2,
            ratingUpdateFunc: (double rating) {
              appController.foodItem1['สิ่งแวดล้อม'] = rating;
            },
          ),
          WidgetRatingStar(
            title: 'บริการ',
            map: appController.foodItem3,
            ratingUpdateFunc: (double rating) {
              appController.foodItem1['บริการ'] = rating;
            },
          ),
          WidgetRatingStar(
            title: 'วัตถุดิบ',
            map: appController.foodItem4,
            ratingUpdateFunc: (double rating) {
              appController.foodItem1['วัตถุดิบ'] = rating;
            },
          ),
        ],
      );
    });
  }
}
