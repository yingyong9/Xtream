// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/views/widget_text.dart';



class WidgetButton extends StatelessWidget {
  const WidgetButton({
    Key? key,
    required this.label,
    required this.pressFunc,
    this.color,
  }) : super(key: key);

  final String label;
  final Function() pressFunc;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: pressFunc,
      child: WidgetText(data: label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? ColorPlate.darkGray,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
