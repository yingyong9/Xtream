// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:xstream/models/video_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form_line.dart';
import 'package:xstream/views/widget_form_multiline.dart';
import 'package:xstream/views/widget_form_no_line.dart';
import 'package:xstream/views/widget_ratting_only.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';

class InsertStar extends StatefulWidget {
  const InsertStar({
    Key? key,
    required this.videoModel,
  }) : super(key: key);

  final VideoModel videoModel;

  @override
  State<InsertStar> createState() => _InsertStarState();
}

class _InsertStarState extends State<InsertStar> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    if (appController.rateStar.value != 0.0) {
      appController.rateStar.value = 0.0;
    }

    if (appController.imageNetworkWidgets.isNotEmpty) {
      appController.imageNetworkWidgets.clear();
    }

    appController.imageNetworkWidgets.add(inkwellWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const WidgetBackButton(),
        title:
            WidgetText(data: 'ติดดาว ${widget.videoModel.mapReview!['type']}'),
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        actions: [
          Obx(() {
            return WidgetTextButton(
              label: 'ส่ง',
              textStyle: AppConstant().bodyStyle(
                  fontSize: 22,
                  color: appController.rateStar.value == 0.0
                      ? Colors.white30
                      : ColorPlate.red),
              pressFunc: () {
                if (appController.rateStar.value != 0.0) {
                  
                }
              },
            );
          })
        ],
      ),
      body: Obx(() {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetRatingStarOnly(
                    initialRating: appController.rateStar.value,
                    ratingUpdateFunc: (p0) {
                      appController.rateStar.value = p0;
                    },
                    sizeIcon: 48,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              imageGridView(),
              // const WidgetFormMultiLine(hint: 'เขียนรีวิวสถานที่นี่้',maxLines: 10,),
              Row(
                children: [
                  WidgetText(data: 'รสชาติ :'),
                  Expanded(child: WidgetFormNoLine()),
                ],
              ),
              Row(
                children: [
                  WidgetText(data: 'วัตถุดิบ :'),
                  Expanded(child: WidgetFormNoLine()),
                ],
              ),
              Row(
                children: [
                  WidgetText(data: 'ราคา :'),
                  Expanded(child: WidgetFormNoLine()),
                ],
              ),
              Row(
                children: [
                  WidgetText(data: 'บริการ :'),
                  Expanded(child: WidgetFormNoLine()),
                ],
              ),
              Row(
                children: [
                  WidgetText(data: 'สถาพแวดล้อม :'),
                  Expanded(child: WidgetFormNoLine()),
                ],
              ),
              Row(
                children: [
                  WidgetText(data: 'อื่นๆ :'),
                  Expanded(child: WidgetFormNoLine()),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  InkWell inkwellWidget() {
    return InkWell(
      onTap: () {
        AppService().takeMultiPhoto();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
        ),
        width: 120,
        height: 120,
        child: const Icon(
          Icons.add_a_photo_outlined,
          size: 36,
        ),
      ),
    );
  }

  GridView imageGridView() {
    return GridView.count(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      children: appController.imageNetworkWidgets,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
    );
  }
}
