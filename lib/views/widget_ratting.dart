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
    this.map,
    required this.ratingUpdateFunc,
  }) : super(key: key);

  final String title;
  final double? sizeIcon;
  final Map<String, dynamic>? map;
  final Function(double) ratingUpdateFunc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WidgetText(
          data: title,
          textStyle: AppConstant()
              .bodyStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16,),
        RatingBar.builder(
          initialRating: map?[title] ?? 0.0,
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          itemSize: sizeIcon ?? 20,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: ratingUpdateFunc,
        ),
      ],
    );
  }
}
