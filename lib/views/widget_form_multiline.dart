// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:xstream/style/style.dart';



class WidgetFormMultiLine extends StatelessWidget {
  const WidgetFormMultiLine({
    Key? key,
    this.textEditingController,
    this.hint,
    this.maxLines,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final String? hint;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: maxLines ?? 5,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: StandardTextStyle.normalWithOpacity,
        // filled: true,
        border: InputBorder.none,
      ),
      controller: textEditingController,
    );
  }
}
