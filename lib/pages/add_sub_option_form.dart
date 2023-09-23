// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:xstream/models/option_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form_underline.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';

class AddSubOptionForm extends StatelessWidget {
  const AddSubOptionForm({
    Key? key,
    required this.optionModel,
  }) : super(key: key);

  final OptionModel optionModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        leading: const WidgetBackButton(),
        title: WidgetText(data: optionModel.title),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          WidgetFormUnderLine(hint: 'กรอกตัวเลือก',),
          Row(
            children: [
              WidgetTextButton(
                label: '+ เพิ่มตัวเลือก',
                pressFunc: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
