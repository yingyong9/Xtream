import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_text.dart';

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        leading: const WidgetBackButton(),
        title: WidgetText(
          data: 'เพิ่มสินค้า',
          textStyle: AppConstant().bodyStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
