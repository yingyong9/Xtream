import 'package:flutter/material.dart';
import 'package:xstream/views/widget_image.dart';


class NonImage extends StatelessWidget {
  const NonImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 3 / 4.0,
        child: Container(
          decoration: BoxDecoration(
            // color: ColorPlate.darkGray,
            border: Border.all(color: Colors.black),
          ),
          alignment: Alignment.center,
          child: WidgetImage(),
          // child: Text(
          //   'ไม่มีรูปภาพ',
          //   style: TextStyle(
          //     color: Colors.white.withOpacity(0.1),
          //     fontSize: 18,
          //     fontWeight: FontWeight.w900,
          //   ),
          // ),
        ),
      ),
    );
  }
}
