// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/views/widget_icon_button.dart';



class WidgetBackButton extends StatelessWidget {
  const WidgetBackButton({
    Key? key,
    this.pressFunc,
  }) : super(key: key);

  final Function()? pressFunc;

  @override
  Widget build(BuildContext context) {
    return WidgetIconButton(
      iconData: Icons.clear,
      pressFunc: pressFunc ??
          () {
            Get.back();
          },
    );
  }
}
