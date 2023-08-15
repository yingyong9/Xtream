// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetImage extends StatelessWidget {
  const WidgetImage({
    Key? key,
    this.path,
    this.size,
  }) : super(key: key);

  final String? path;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path ?? 'images/happy.png',
      width: size,
      height: size,
    );
  }
}
