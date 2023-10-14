// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:xstream/style/style.dart';

class WidgetFormLine extends StatelessWidget {
  const WidgetFormLine({
    Key? key,
    this.textEditingController,
    this.hint,
    this.textInputType,
    this.labelWidget,
    this.prefixWidget,
    this.suffixWidget,
    this.changeFunc,
    this.validateFunc,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final String? hint;
  final TextInputType? textInputType;
  final Widget? labelWidget;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Function(String)? changeFunc;
  final String? Function(String?)? validateFunc;

  @override
  Widget build(BuildContext context) {
    return TextFormField(validator: validateFunc,
      onChanged: changeFunc,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(suffixIcon: suffixWidget,
        prefixIcon: prefixWidget,
        label: labelWidget,
        hintText: hint,
        hintStyle: StandardTextStyle.normalWithOpacity,
        // filled: true,
        // border: InputBorder.none,
      ),
      controller: textEditingController,
    );
  }
}
