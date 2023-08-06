// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

class WidgetImageFile extends StatelessWidget {
  const WidgetImageFile({
    Key? key,
    required this.fileImage,
  }) : super(key: key);

  final File fileImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Image.file(fileImage, fit: BoxFit.cover,),borderRadius: BorderRadius.circular(15),
    );
  }
}
