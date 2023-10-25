// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'package:xstream/style/style.dart';
import 'package:xstream/views/widget_text.dart';

class WidgetGfButton extends StatelessWidget {
  const WidgetGfButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.color,
    this.textColor,
    this.fullScreen,
    this.gfButtonType,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;
  final Color? color;
  final Color? textColor;
  final bool? fullScreen;
  final GFButtonType? gfButtonType;
  

  @override
  Widget build(BuildContext context) {
    return GFButton(textColor: textColor,
      onPressed: pressFunc,
      child: WidgetText(data: label),
      fullWidthButton: fullScreen,
      color: color ?? GFColors.PRIMARY,type: gfButtonType ?? GFButtonType.solid,
    );
  }
}
