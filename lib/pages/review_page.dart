import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xstream/bodys/body_food.dart';
import 'package:xstream/bodys/body_resourse.dart';
import 'package:xstream/bodys/body_travel.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/utility/app_snackbar.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form_line.dart';
import 'package:xstream/views/widget_form_multiline.dart';
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

  var titles = <String>[
    'อาหาร',
    'ที่พัก',
    'ท่องเทียว',
    'ภาพยนต์',
    'เพลง',
    'กีฬา',
    'แฟชั่น',
    'เครื่องใช้ไฟฟ้า',
    'รถยนต์',
    'สัตร์เลียง',
  ];

  var bodys = <Widget>[
    const BodyFood(),
    const BodyResourse(),
    const BodyTravel(),
    WidgetText(data: 'data'),
    WidgetText(data: 'data'),
    WidgetText(data: 'data'),
    WidgetText(data: 'data'),
    WidgetText(data: 'data'),
    WidgetText(data: 'data'),
    WidgetText(data: 'data'),
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
                GridView.count(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: appController.imageNetworkWidgets,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
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
                  decoration: InputDecoration(hintText: 'รายละเอียด'),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.pin_drop),
                        WidgetText(data: 'Location')
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.home),
                        WidgetText(data: 'แทรคร้านค้า')
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),

                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: titles.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        appController.indexCategory.value = index;
                        print(
                            'You tab indexCategory ---> ${appController.indexCategory}');
                      },
                      child: SizedBox(
                        width: 120,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            WidgetText(data: titles[index]),
                            Obx(() {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: 4,
                                color:
                                    appController.indexCategory.value == index
                                        ? Colors.blue
                                        : ColorPlate.back1,
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                bodys[appController.indexCategory.value],

                // DefaultTabController(
                //   length: titles.length,
                //   initialIndex: 0,
                //   child: Scaffold(
                //     appBar: TabBar(
                //       tabs: titles.map((e) => WidgetText(data: e)).toList(),
                //       isScrollable: true,
                //     ),
                //     body: WidgetText(data: 'data'),
                //   ),
                // ),
              ],
            ),
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
}
