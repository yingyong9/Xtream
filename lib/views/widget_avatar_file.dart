// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:xstream/style/style.dart';



class WidgetAvatarFile extends StatelessWidget {
  const WidgetAvatarFile({
    Key? key,
    required this.file,
  }) : super(key: key);

  final File file;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: ColorPlate.white),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: ColorPlate.back1,
            border: Border.all(color: ColorPlate.back1, width: 4),
            image: DecorationImage(image: FileImage(file), fit: BoxFit.cover)),
      ),
    );
  }
}
