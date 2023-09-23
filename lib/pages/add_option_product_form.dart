import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';

class AddOptionProductForm extends StatelessWidget {
  const AddOptionProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        leading: const WidgetBackButton(),
        title: const WidgetText(data: 'ใส่ชื่อตัวเลือก'),
        actions: [
          WidgetTextButton(
            label: 'บันทึก',
            pressFunc: () {},
          )
        ],
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [WidgetForm()],
      ),
    );
  }
}
