// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/views/widget_text.dart';

class WidgetRatingStar extends StatelessWidget {
  const WidgetRatingStar({
    Key? key,
    required this.title,
    this.sizeIcon,
  }) : super(key: key);

  final String title;
  final double? sizeIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: WidgetText(
            data: title,
            textStyle: AppConstant()
                .bodyStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 3,
          child: RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: sizeIcon ?? 20,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (value) {
              print('onRatingUpdaet ---> $value');
            },
          ),
        ),
      ],
    );
  }
}
