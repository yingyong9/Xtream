// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:xstream/models/option_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_snackbar.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form_underline.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';

class AddSubOptionForm extends StatefulWidget {
  const AddSubOptionForm({
    Key? key,
    required this.indexOptionModel,
  }) : super(key: key);

  final int indexOptionModel;

  @override
  State<AddSubOptionForm> createState() => _AddSubOptionFormState();
}

class _AddSubOptionFormState extends State<AddSubOptionForm> {
  AppController appController = Get.put(AppController());
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    print(
        'optionsModel[${widget.indexOptionModel}] ---> ${appController.optionModels[widget.indexOptionModel].toMap()}');

    appController.displaySave.value = false;
    if (appController.subOptions.isNotEmpty) {
      appController.subOptions.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        leading: const WidgetBackButton(),
        title: WidgetText(
            data: appController.optionModels[widget.indexOptionModel].title),
        centerTitle: true,
        actions: [
          Obx(() {
            return appController.displaySave.value
                ? WidgetTextButton(
                    label: 'บันทึก',
                    pressFunc: () {
                      if (textEditingController.text.isNotEmpty) {
                        appController.subOptions
                            .add(textEditingController.text);
                        textEditingController.clear();
                      }

                      print(
                          'optionModel ---> ${appController.subOptions.toString()}');

                      Map<String, dynamic> map = appController
                          .optionModels[widget.indexOptionModel]
                          .toMap();
                      // map['subOptions'] = appController.subOptions;

                      var strings = map['subOptions'];

                      for (var element in appController.subOptions) {
                        strings.add(element);
                      }

                      map['subOptions'] = strings;

                      OptionModel optionModel = OptionModel.fromMap(map);

                      appController.optionModels[widget.indexOptionModel] =
                          optionModel;
                      Get.back();
                    },
                  )
                : const SizedBox();
          })
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          Obx(() {
            print('subOptions length --> ${appController.subOptions.length}');
            return (appController.subOptions.isEmpty)
                ? const SizedBox()
                : ListView.builder(
                    itemCount: appController.subOptions.length,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      height: 40,
                      decoration: BoxDecoration(
                          color: ColorPlate.darkGray,
                          border: Border(
                              bottom: BorderSide(color: Colors.grey.shade400))),
                      child: WidgetText(data: appController.subOptions[index]),
                    ),
                  );
          }),
          WidgetFormUnderLine(
            textEditingController: textEditingController,
            hint: 'กรอกตัวเลือก',
            changeFunc: (p0) {
              appController.displaySave.value = true;
            },
          ),
          Row(
            children: [
              WidgetTextButton(
                label: '+ เพิ่มตัวเลือก',
                pressFunc: () {
                  if (textEditingController.text.isEmpty) {
                    AppSnackBar(title: 'ตัวเลือก', message: 'กรุณากรอกตัวเลือก')
                        .errorSnackBar();
                  } else {
                    appController.subOptions.add(textEditingController.text);
                    textEditingController.clear();
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
