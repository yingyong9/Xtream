// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:xstream/models/comment_post_model.dart';

import 'package:xstream/models/video_model.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_avatar.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_gf_button.dart';
import 'package:xstream/views/widget_icon_button_gf.dart';
import 'package:xstream/views/widget_image_network.dart';
import 'package:xstream/views/widget_text.dart';

class ReviewDetailPage extends StatefulWidget {
  const ReviewDetailPage({
    Key? key,
    required this.videoModel,
    required this.docIdVideo,
  }) : super(key: key);

  final VideoModel videoModel;
  final String docIdVideo;

  @override
  State<ReviewDetailPage> createState() => _ReviewDetailPageState();
}

class _ReviewDetailPageState extends State<ReviewDetailPage> {
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      streamSubscription;

  AppController appController = Get.put(AppController());
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readCommentPost();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  Future<void> readCommentPost() async {
    if (appController.commentPostModels.isNotEmpty) {
      appController.commentPostModels.clear();
    }

    streamSubscription = FirebaseFirestore.instance
        .collection('commentPost')
        .doc(widget.docIdVideo)
        .collection('comment')
        .orderBy('timestamp')
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        if (appController.commentPostModels.isNotEmpty) {
          appController.commentPostModels.clear();
        }

        for (var element in event.docs) {
          CommentPostModel commentPostModel =
              CommentPostModel.fromMap(element.data());
          appController.commentPostModels.add(commentPostModel);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return SafeArea(
          child: ListView(
            children: [
              head(),
              displayImage(boxConstraints),
              WidgetText(
                data: widget.videoModel.mapReview!['nameReview'],
                textStyle: AppConstant()
                    .bodyStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              WidgetText(data: widget.videoModel.mapReview!['review']),
              Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: RatingBar.builder(
                      initialRating: widget.videoModel.mapReview!['rating'],
                      itemSize: 20,
                      itemCount: 5,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) {},
                    ),
                  ),
                  WidgetText(
                      data: widget.videoModel.mapReview!['rating'].toString()),
                ],
              ),
              WidgetGfButton(
                label: 'รีวิวเพื่อสังคม',
                pressFunc: () {},
              ),
              Obx(() {
                return appController.commentPostModels.isEmpty
                    ? const SizedBox()
                    : ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appController.commentPostModels.length,
                        itemBuilder: (context, index) => Row(
                          children: [
                            WidgetAvatar(urlImage: appController.commentPostModels[index].mapUserModel['urlAvatar'], size: 30,),
                            WidgetText(
                                data: appController.commentPostModels[index].post),
                          ],
                        ),
                      );
              }),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        );
      }),
      bottomSheet: WidgetForm(
        textEditingController: textEditingController,
        hint: 'ความคิดเห็น',
        suffixWidget: WidgetIconButtonGF(
          iconData: Icons.send,
          pressFunc: () async {
            print('docIdVideo ====> ${widget.docIdVideo}');

            if (textEditingController.text.isNotEmpty) {
              CommentPostModel commentPostModel = CommentPostModel(
                  post: textEditingController.text,
                  timestamp: Timestamp.fromDate(DateTime.now()),
                  mapUserModel: widget.videoModel.mapUserModel);

              FirebaseFirestore.instance
                  .collection('commentPost')
                  .doc(widget.docIdVideo)
                  .collection('comment')
                  .doc()
                  .set(commentPostModel.toMap())
                  .then((value) {
                textEditingController.clear();
              });
            }
          },
        ),
      ),
    );
  }

  SizedBox displayImage(BoxConstraints boxConstraints) {
    return SizedBox(
      height: boxConstraints.maxHeight * 0.7,
      child: widget.videoModel.mapReview!['urlImageReviews'].isEmpty
          ? WidgetImageNetwork(
              urlImage: widget.videoModel.image,
              boxFit: BoxFit.cover,
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.videoModel.mapReview!['urlImageReviews'].length,
              itemBuilder: (context, index) => WidgetImageNetwork(
                  urlImage: widget.videoModel.mapReview!['urlImageReviews']
                      [index]),
            ),
    );
  }

  Row head() {
    return Row(
      children: [
        const WidgetBackButton(),
        WidgetAvatar(
          urlImage: widget.videoModel.mapUserModel['urlAvatar'],
          size: 25,
        ),
        const SizedBox(
          width: 8,
        ),
        WidgetText(
          data: widget.videoModel.mapUserModel['name'],
          textStyle: AppConstant()
              .bodyStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
