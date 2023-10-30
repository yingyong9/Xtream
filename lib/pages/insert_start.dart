// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:xstream/models/video_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_ratting_only.dart';
import 'package:xstream/views/widget_text.dart';

class InsertStar extends StatefulWidget {
  const InsertStar({
    Key? key,
    required this.videoModel,
  }) : super(key: key);

  final VideoModel videoModel;

  @override
  State<InsertStar> createState() => _InsertStarState();
}

class _InsertStarState extends State<InsertStar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const WidgetBackButton(),
        title: WidgetText(data: 'ติดดาว ${widget.videoModel.mapReview!['type']}'),
        backgroundColor: ColorPlate.back1,
        elevation: 0,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WidgetRatingStarOnly(
            ratingUpdateFunc: (p0) {},
          ),
        ],
      ),
    );
  }








  
}
