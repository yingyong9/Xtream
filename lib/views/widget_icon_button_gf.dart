// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:getwidget/getwidget.dart';

class WidgetIconButtonGF extends StatelessWidget {
  const WidgetIconButtonGF({
    Key? key,
    required this.iconData,
    required this.pressFunc,
    this.color,
    this.size,
    this.gfButtonType,
  }) : super(key: key);

  final IconData iconData;
  final Function() pressFunc;
  final Color? color;
  final double? size;
  final GFButtonType? gfButtonType;

  @override
  Widget build(BuildContext context) {
    return GFIconButton(
      icon: Icon(iconData),
      onPressed: pressFunc,
      type: gfButtonType ?? GFButtonType.transparent,
      color: color ?? GFColors.PRIMARY,
    );
  }
}
