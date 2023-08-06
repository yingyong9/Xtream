// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:xstream/style/style.dart';



class WidgetForm extends StatelessWidget {
  const WidgetForm({
    Key? key,
    this.textEditingController,
    this.hint,
    this.textInputType,
    this.labelWidget,
    this.prefixWidget,
    this.changeFunc,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final String? hint;
  final TextInputType? textInputType;
  final Widget? labelWidget;
  final Widget? prefixWidget;
  final Function(String)? changeFunc;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: changeFunc,
      keyboardType: textInputType ?? TextInputType.text,
      decoration: InputDecoration(prefixIcon: prefixWidget,
        label: labelWidget,
        hintText: hint,
        hintStyle: StandardTextStyle.normalWithOpacity,
        filled: true,
        border: InputBorder.none,
      ),
      controller: textEditingController,
    );
  }
}
