// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetImage extends StatelessWidget {
  const WidgetImage({
    Key? key,
    this.path,
    this.size,
    this.tapFunc,
  }) : super(key: key);

  final String? path;
  final double? size;
  final Function()? tapFunc;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: tapFunc,
      child: Image.asset(
        path ?? 'images/tuktuk.png',
        width: size,
        height: size,
      ),
      
    );
  }
}
