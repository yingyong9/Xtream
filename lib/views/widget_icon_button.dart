// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetIconButton extends StatelessWidget {
  const WidgetIconButton({
    Key? key,
    required this.iconData,
    required this.pressFunc,
    this.color,
  }) : super(key: key);

  final IconData iconData;
  final Function() pressFunc;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: pressFunc, icon: Icon(iconData, color: color,));
  }
}
