// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetText extends StatelessWidget {
  const WidgetText({
    Key? key,
    required this.data,
    this.textStyle,
  }) : super(key: key);

  final String data;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(data, style: textStyle,);
  }
}
