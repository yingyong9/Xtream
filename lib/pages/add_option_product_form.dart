import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:xstream/models/option_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_form_underline.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';

class AddOptionProductForm extends StatefulWidget {
  const AddOptionProductForm({super.key});

  @override
  State<AddOptionProductForm> createState() => _AddOptionProductFormState();
}

class _AddOptionProductFormState extends State<AddOptionProductForm> {
  AppController appController = Get.put(AppController());
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    appController.displaySave.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        leading: const WidgetBackButton(),
        title: const WidgetText(data: 'ใส่ชื่อตัวเลือก'),
        actions: [
          Obx(() {
            return appController.displaySave.value
                ? WidgetTextButton(
                    label: 'บันทึก',
                    pressFunc: () {
                      OptionModel optionModel =
                          OptionModel(title: textEditingController.text, subOptions: []);
                      appController.optionModels.add(optionModel);
                      Get.back();
                    },
                  )
                : const SizedBox();
          })
        ],
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          WidgetFormUnderLine(
            textEditingController: textEditingController,
            hint: 'กรอกชื่อตัวเลือก',
            changeFunc: (p0) {
              appController.displaySave.value = true;
            },
          )
        ],
      ),
    );
  }
}
