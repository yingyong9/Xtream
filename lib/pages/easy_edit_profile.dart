// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_icon_button.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';



class EasyEditProfile extends StatefulWidget {
  const EasyEditProfile({
    Key? key,
    required this.title,
    required this.text,
    required this.keyMap,
  }) : super(key: key);

  final String title;
  final String text;
  final String keyMap;

  @override
  State<EasyEditProfile> createState() => _EasyEditProfileState();
}

class _EasyEditProfileState extends State<EasyEditProfile> {
  TextEditingController textEditingController = TextEditingController();
  bool change = false;

  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GestureDetector(
        onTap: () {
          print('Click Tab');
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Container(
          color: ColorPlate.back1,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              displayTop(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: WidgetText(data: widget.title),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextFormField(
                  onChanged: (value) {
                    change = true;
                    setState(() {});
                  },
                  controller: textEditingController,
                  decoration: InputDecoration(
                      suffixIcon: WidgetIconButton(
                    iconData: Icons.cancel,
                    pressFunc: () {
                      textEditingController.text = '';
                    },
                  )),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Row displayTop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WidgetTextButton(
          textStyle: TextStyle(color: ColorPlate.white, fontSize: 18),
          label: 'ยกเลิก',
          pressFunc: () {
            Get.back();
          },
        ),
        WidgetText(
          data: widget.title,
          textStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        WidgetTextButton(
          textStyle: TextStyle(
              color: change ? ColorPlate.red : ColorPlate.white, fontSize: 18),
          label: 'บันทึก',
          pressFunc: () {
            if (change) {
              Map<String, dynamic> map =
                  appController.currentUserModels.last.toMap();
              map[widget.keyMap] = textEditingController.text;
              print('map ---> $map');
              AppService().processEditProfile(map: map);
            }
          },
        ),
      ],
    );
  }
}
