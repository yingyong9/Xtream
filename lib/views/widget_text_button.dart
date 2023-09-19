// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:xstream/views/widget_text.dart';



class WidgetTextButton extends StatelessWidget {
  const WidgetTextButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.textStyle,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;
  final TextStyle? textStyle;
  

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: pressFunc, child: WidgetText(data: label, textStyle: textStyle,));
  }
}
