// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:xstream/style/style.dart';

class WidgetFormUnderLine extends StatelessWidget {
  const WidgetFormUnderLine({
    Key? key,
    this.textEditingController,
    this.hint,
    this.textInputType,
    this.labelWidget,
    this.prefixWidget,
    this.suffixWidget,
    this.changeFunc,
    this.fillColor,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final String? hint;
  final TextInputType? textInputType;
  final Widget? labelWidget;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Function(String)? changeFunc;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: changeFunc,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(suffixIcon: suffixWidget,
        prefixIcon: prefixWidget,
        label: labelWidget,
        hintText: hint,
        hintStyle: StandardTextStyle.normalWithOpacity,
        filled: true,
        fillColor: fillColor,
        // border: InputBorder.none,
      ),
      controller: textEditingController,
    );
  }
}
