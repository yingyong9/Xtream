// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:xstream/models/video_model.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/views/widget_avatar.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_image_network.dart';
import 'package:xstream/views/widget_text.dart';

class ReviewDetailPage extends StatelessWidget {
  const ReviewDetailPage({
    Key? key,
    required this.videoModel,
  }) : super(key: key);

  final VideoModel videoModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return SafeArea(
          child: ListView(
            children: [
              Row(
                children: [
                  const WidgetBackButton(),
                  WidgetAvatar(
                    urlImage: videoModel.mapUserModel['urlAvatar'],
                    size: 25,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  WidgetText(
                    data: videoModel.mapUserModel['name'],
                    textStyle: AppConstant()
                        .bodyStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: boxConstraints.maxHeight * 0.7,
                child: videoModel.mapReview!['urlImageReviews'].isEmpty
                    ? WidgetImageNetwork(
                        urlImage: videoModel.image,
                        boxFit: BoxFit.cover,
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            videoModel.mapReview!['urlImageReviews'].length,
                        itemBuilder: (context, index) => WidgetImageNetwork(
                            urlImage: videoModel.mapReview!['urlImageReviews']
                                [index]),
                      ),
              ),
              WidgetText(data: videoModel.mapReview!['nameReview']),
              Text(videoModel.mapReview!['review']),
              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: RatingBar.builder(
                      initialRating: videoModel.mapReview!['rating'],
                      itemSize: 20,
                      itemCount: 5,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) {},
                    ),
                  ),
                  WidgetText(data: videoModel.mapReview!['rating'].toString()),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
