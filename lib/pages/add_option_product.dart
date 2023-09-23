import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:xstream/pages/add_option_product_form.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_text.dart';

class AddOptionProduct extends StatelessWidget {
  const AddOptionProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        leading: WidgetBackButton(),
        title: WidgetText(data: 'ใส่ชื่อตัวเลือก'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          GFButton(
            onPressed: () {
              Get.to(const AddOptionProductForm());
            },
            fullWidthButton: true,
            text: '+ เพิ่มชื่อตัวเลือก',
            type: GFButtonType.outline,
          ),
        ],
      ),
    );
  }
}
