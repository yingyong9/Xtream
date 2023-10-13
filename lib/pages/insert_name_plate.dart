import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form_line.dart';
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
        return ListView(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      typeDropdown(),
                      WidgetFormLine(labelWidget: WidgetText(data: 'Name :'),),
                      WidgetFormLine(labelWidget: WidgetText(data: 'Phone :'),),
                    ],
                  ),
                ),
              ],
            )
          ],
        );
      }),
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
