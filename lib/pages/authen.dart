import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:xstream/pages/check_pincode.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_snackbar.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_form_line.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
          LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          child: SizedBox(
            width: double.infinity,
            height: boxConstraints.maxHeight,
            child: Stack(
              children: [
                ListView(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    displayForm(),
                    displayButton(),
                  ],
                ),
                const WidgetBackButton(),
              ],
            ),
          ),
        );
      })),
    );
  }

  Row displayForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          child: WidgetFormLine(
            hint: 'กรอกเบอร์โทรศัพย์มือถือ',
            textEditingController: textEditingController,
            textInputType: TextInputType.phone,
          ),
        ),
      ],
    );
  }

  Row displayButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          margin: const EdgeInsets.only(top: 30),
          child: WidgetButton(
            gfButtonShape: GFButtonShape.pills,
            color: ColorPlate.red,
            label: 'ถัดไป',
            pressFunc: () {
              if (textEditingController.text.isEmpty) {
                AppSnackBar(
                        title: 'No Phone Number',
                        message: 'Please Fill Phone Number')
                    .errorSnackBar();
              } else {
                Get.to(CheckPincode(phoneNumber: textEditingController.text))!
                    .then((value) => textEditingController.text = '');
              }
            },
          ),
        ),
      ],
    );
  }
}
