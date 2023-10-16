// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.label,
    this.pressFunc,
    this.color,
    this.gfButtonShape,
    this.fullWidthButton,
    this.iconWidget,
    this.textColor,
  }) : super(key: key);

  final String label;
  final Function()? pressFunc;
  final Color? color;
  final GFButtonShape? gfButtonShape;
  final bool? fullWidthButton;
  final Widget? iconWidget;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GFButton(
      textColor: textColor,
      onPressed: pressFunc,
      text: label,
      color: color ?? GFColors.PRIMARY,
      shape: gfButtonShape ?? GFButtonShape.standard,
      fullWidthButton: fullWidthButton,
      icon: iconWidget,
    );
  }
}
