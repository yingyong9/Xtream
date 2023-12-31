// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:xstream/style/style.dart';

class WidgetAvatar extends StatelessWidget {
  const WidgetAvatar({
    Key? key,
    required this.urlImage,
    this.size,
  }) : super(key: key);

  final String urlImage;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 100,
      height: size ?? 100,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: ColorPlate.white),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: ColorPlate.back1,
            border: Border.all(color: ColorPlate.back1, width: 4),
            image: DecorationImage(image: NetworkImage(urlImage))),
      ),
    );
  }
}
