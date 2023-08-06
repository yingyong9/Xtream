// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';



class WidgetImageNetwork extends StatelessWidget {
  const WidgetImageNetwork({
    Key? key,
    required this.urlImage,
    this.size,
    this.boxFit,
    this.tapFunc,
  }) : super(key: key);

  final String urlImage;
  final double? size;
  final BoxFit? boxFit;
  final Function()? tapFunc;

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: tapFunc,
      child: Image.network(
        urlImage,
        width: size,
        height: size,
        fit: boxFit,
        // errorBuilder: (context, error, stackTrace) => NonImage(),
      ),
    );
  }
}
