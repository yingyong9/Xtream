// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class WidgetRatingStarOnly extends StatelessWidget {
  const WidgetRatingStarOnly({
    Key? key,
    
    this.sizeIcon,
    this.map,
    required this.ratingUpdateFunc,
  }) : super(key: key);

 
  final double? sizeIcon;
  final Map<String, dynamic>? map;
  final Function(double) ratingUpdateFunc;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 0.0,
      minRating: 1,
      direction: Axis.horizontal,
      itemCount: 5,
      itemSize: sizeIcon ?? 20,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: ratingUpdateFunc,
    );
  }
}
