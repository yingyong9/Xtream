// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:xstream/models/video_model.dart';
import 'package:xstream/views/widget_image_network.dart';

class ListReview extends StatelessWidget {
  const ListReview({
    super.key,
    required this.videoModel,
  });

  final VideoModel videoModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: WidgetImageNetwork(
              urlImage: videoModel.mapReview!['urlImageReviews'].last)),
    );
  }
}
