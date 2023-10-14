import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/models/landmark_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_snackbar.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form_line.dart';
import 'package:xstream/views/widget_gf_button.dart';
import 'package:xstream/views/widget_text.dart';

class InsertNamePlate extends StatefulWidget {
  const InsertNamePlate({super.key});

  @override
  State<InsertNamePlate> createState() => _InsertNamePlateState();
}

class _InsertNamePlateState extends State<InsertNamePlate> {
  AppController appController = Get.put(AppController());

  var titles = <String>[
    'ร้านอาหาร',
    'ภัตราคาร',
    'ร้านบุพเพต์',
    'ร้านอาหารจีน',
    'ร้านกาแฟ',
    'โรงแรม',
    'รีสอร์ท',
    'สถานที่ท่องเที่ยว',
    'โฮมสเตร์',
  ];

  final formStateKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    appController.chooseTypes.clear();
    appController.chooseTypes.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const WidgetBackButton(),
        title: const WidgetText(data: 'คุณเป็นคนแรกที่รีวิวที่นี่'),
        centerTitle: true,
        backgroundColor: ColorPlate.back1,
        elevation: 0,
      ),
      body: Obx(() {
        return Form(
          key: formStateKey,
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Column(
                        children: [
                          typeDropdown(),
                          WidgetFormLine(
                            textEditingController: nameController,
                            labelWidget: const WidgetText(data: 'Name :'),
                            validateFunc: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return 'โปรดกรองชื่อ';
                              } else {
                                return null;
                              }
                            },
                          ),
                          WidgetFormLine(
                            textEditingController: phoneController,
                            labelWidget: const WidgetText(data: 'Phone :'),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
      bottomSheet: Container(
        decoration: const BoxDecoration(color: ColorPlate.back1),
        child: WidgetGfButton(
          label: 'Add',
          fullScreen: true,
          color: ColorPlate.red,
          pressFunc: () async {
            if (appController.chooseTypes.last == null) {
              AppSnackBar(title: 'ชนิด', message: 'โปรดเลือกชนิด')
                  .errorSnackBar();
            } else {
              if (formStateKey.currentState!.validate()) {
                LandMarkModel landMarkModel = LandMarkModel(
                    name: nameController.text,
                    phone: phoneController.text,
                    type: appController.chooseTypes.last!,
                    geoPoint: GeoPoint(appController.positions.last.latitude,
                        appController.positions.last.longitude));

                FirebaseFirestore.instance
                    .collection('landmark')
                    .doc()
                    .set(landMarkModel.toMap())
                    .then((value) {
                  print('Add LandMark Success');
                });
              }
            }
          },
        ),
      ),
    );
  }

  Widget typeDropdown() {
    return DropdownButton(
      isExpanded: true,
      hint: const WidgetText(data: 'โปรดเลือก'),
      value: appController.chooseTypes.last,
      items: titles
          .map(
            (e) => DropdownMenuItem(
              child: WidgetText(data: e),
              value: e,
            ),
          )
          .toList(),
      onChanged: (value) {
        appController.chooseTypes.add(value);
      },
    );
  }
}
