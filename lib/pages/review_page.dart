import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/utility/app_snackbar.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form_line.dart';
import 'package:xstream/views/widget_image_file.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  AppController appController = Get.put(AppController());
  TextEditingController textEditingController = TextEditingController();

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
                Row(
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
                    WidgetTextButton(
                      label: 'บันทึก',
                      pressFunc: () async {
                        if (appController.files.isEmpty) {
                          AppSnackBar(
                                  title: 'Image ?', message: 'กรุณาเลือกภาพ')
                              .errorSnackBar();
                        } else if (textEditingController.text.isEmpty) {
                          AppSnackBar(
                                  title: 'ซื่อร้านค้า ?',
                                  message: 'กรุณากรอก ซื่อร้านค้า')
                              .errorSnackBar();
                        } else {
                          AppService()
                              .processUploadFileImageReview()
                              .then((value) {
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
                ),
                Row(
                  children: [
                    appController.xFiles.isEmpty
                        ? const SizedBox()
                        : WidgetText(data: 'Have image'),
                    InkWell(
                      onTap: () {
                        AppService().takeMultiPhoto();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
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
                    ),
                  ],
                ),
                WidgetFormLine(
                  hint: 'ชื่อร้านค้า',
                  textEditingController: textEditingController,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
