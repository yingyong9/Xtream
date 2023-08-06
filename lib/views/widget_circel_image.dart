import 'package:flutter/material.dart';

class WidgetCircleImage extends StatelessWidget {
  const WidgetCircleImage({key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120 + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(left: 18),
      alignment: Alignment.bottomLeft,
      child: OverflowBox(
        alignment: Alignment.bottomLeft,
        minHeight: 20,
        maxHeight: 300,
        child: Container(
            height: 74,
            width: 74,
            margin: EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(44),
              color: Colors.black,
              border: Border.all(
                color: Colors.white,
                width: 1,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'images/logo3.png',
                fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }
}
