// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:xstream/bodys/body_food.dart';
import 'package:xstream/bodys/body_resourse.dart';
import 'package:xstream/bodys/body_travel.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/utility/app_snackbar.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_form_line.dart';
import 'package:xstream/views/widget_ratting.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({
    Key? key,
    required this.indexReviewCat,
  }) : super(key: key);

  final int indexReviewCat;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  AppController appController = Get.put(AppController());
  TextEditingController textEditingController = TextEditingController();

  var titles = <String>[
    'อาหาร',
    'ท่องเทียว/ทัวร์',
    'ที่พัก',
  ];

  var bodys = <Widget>[
    const BodyFood(),
    const BodyTravel(),
    const BodyResourse(),
  ];

  @override
  void initState() {
    super.initState();
    if (appController.imageNetworkWidgets.isNotEmpty) {
      appController.imageNetworkWidgets.clear();
    }
    appController.imageNetworkWidgets.add(inkwellWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                head(),
                imageGridView(),
                const SizedBox(
                  height: 16,
                ),
                WidgetFormLine(
                  hint: 'หัวข้อ',
                  textEditingController: textEditingController,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration:
                      const InputDecoration(hintText: 'เขียนรีวิวสถานที่นี้'),
                ),
                const SizedBox(
                  height: 32,
                ),
                WidgetRatingStar(
                  title: 'ให้คะแนนสถานที่นี้',
                  sizeIcon: 30,
                  map: appController.foodSum,
                  ratingUpdateFunc: (double rating) {
                    appController.foodSum['โดยรวม'] = rating;
                  },
                ),
                const SizedBox(height: 64,)
              ],
            ),
          ),
        );
      }),
      bottomSheet: Container(decoration: const BoxDecoration(color: ColorPlate.back1),
        child: WidgetButton(
          label: 'โพสต์',
          pressFunc: () {},fullWidthButton: true,color: ColorPlate.red,
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

  Row head() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WidgetBackButton(
          pressFunc: () {
            if (appController.files.isNotEmpty) {
              appController.files.clear();
              appController.nameFiles.clear();
            }
            Get.back();
          },
        ),
        WidgetText(
          data: AppConstant.reviewCats[widget.indexReviewCat],
          textStyle: AppConstant().bodyStyle(fontSize: 20),
        ),
        WidgetTextButton(
          label: 'บันทึก',
          pressFunc: () async {
            if (appController.files.isEmpty) {
              AppSnackBar(title: 'Image ?', message: 'กรุณาเลือกภาพ')
                  .errorSnackBar();
            } else if (textEditingController.text.isEmpty) {
              AppSnackBar(
                      title: 'ซื่อร้านค้า ?', message: 'กรุณากรอก ซื่อร้านค้า')
                  .errorSnackBar();
            } else {
              AppService().processUploadFileImageReview().then((value) {
                Map<String, dynamic> map = {};
                map['urlImageReview'] = value;
                map['nameShop'] = textEditingController.text;

                print('map ---> $map');

                // appController.mapReview.value = map;
                Get.back(result: map);
              });
            }
          },
        )
      ],
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
}
