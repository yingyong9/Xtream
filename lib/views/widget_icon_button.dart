// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetIconButton extends StatelessWidget {
  const WidgetIconButton({
    Key? key,
    required this.iconData,
    required this.pressFunc,
    this.color,
    this.size,
  }) : super(key: key);

  final IconData iconData;
  final Function() pressFunc;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: pressFunc,
        icon: Icon(
          iconData,
          color: color,size: size,
        ));
  }
}
