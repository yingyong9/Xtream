// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:xstream/models/comment_model.dart';
import 'package:xstream/models/video_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_icon_button.dart';
import 'package:xstream/views/widget_image_network.dart';
import 'package:xstream/views/widget_text.dart';

class TikTokCommentBottomSheet extends StatefulWidget {
  const TikTokCommentBottomSheet({
    Key? key,
    required this.docIdVideo,
    required this.indexVideo,
  }) : super(key: key);

  final String docIdVideo;
  final int indexVideo;

  @override
  State<TikTokCommentBottomSheet> createState() =>
      _TikTokCommentBottomSheetState();
}

class _TikTokCommentBottomSheetState extends State<TikTokCommentBottomSheet> {
  AppController appController = Get.put(AppController());
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppService().readCommentModelByDocIdVideo(docIdVideo: widget.docIdVideo);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: ColorPlate.back1,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(4),
            height: 4,
            width: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            height: 24,
            alignment: Alignment.center,
            // color: Colors.white.withOpacity(0.2),
            child: Obx(() {
              return Text(
                '${appController.videoModels[widget.indexVideo].comment} Comment',
                style: StandardTextStyle.small,
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              return appController.commentModels.isEmpty
                  ? const SizedBox()
                  : ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: appController.commentModels.length,
                      itemBuilder: (context, index) => _CommentRow(
                          commentModel: appController.commentModels[index]),
                    );
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: WidgetForm(
              textEditingController: textEditingController,
              suffixWidget: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () async {
                      print('tap up');
                      processAddComment(upBool: true);
                    },
                    child: const Icon(Icons.arrow_circle_up),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () async {
                      print('tap down');
                      processAddComment(upBool: false);
                    },
                    child: const Icon(Icons.arrow_circle_down),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
              // suffixWidget: WidgetIconButton(
              //   iconData: Icons.send,
              //   pressFunc: () async {
              //     print('send at docIdVideo ---> ${widget.docIdVideo}');

              //     Map<String, dynamic> map =
              //         appController.currentUserModels.last.toMap();

              //     print('mapCurrentLogin ---> $map');

              //     print('textEdit ---> ${textEditingController.text}');

              //     CommentModel commentModel = CommentModel(
              //         comment: textEditingController.text,
              //         timestamp: Timestamp.fromDate(DateTime.now()),
              //         mapComment: map);

              //     AppService()
              //         .insertComment(
              //             docIdVideo: widget.docIdVideo,
              //             mapComment: commentModel.toMap())
              //         .then((value) {
              //       print('Insert Comment Success');
              //       textEditingController.text = '';
              //       AppService().readCommentModelByDocIdVideo(
              //           docIdVideo: widget.docIdVideo);

              //       Map<String, dynamic> map =
              //           appController.videoModels[widget.indexVideo].toMap();
              //       int comment =
              //           appController.videoModels[widget.indexVideo].comment!;
              //       comment++;
              //       map['comment'] = comment;

              //       appController.videoModels[widget.indexVideo] =
              //           VideoModel.fromMap(map);

              //       FirebaseFirestore.instance
              //           .collection('video')
              //           .doc(widget.docIdVideo)
              //           .update(map);
              //     });
              //   },
              // ),
            ),
          ),
        ],
      ),
    );
  }

  void processAddComment({required bool upBool}) {
    Map<String, dynamic> map = appController.currentUserModels.last.toMap();

    CommentModel commentModel = CommentModel(
        comment: textEditingController.text,
        timestamp: Timestamp.fromDate(DateTime.now()),
        mapComment: map, upBool: upBool);

    AppService()
        .insertComment(
            docIdVideo: widget.docIdVideo, mapComment: commentModel.toMap())
        .then((value) {
      print('Insert Comment Success');
      textEditingController.text = '';
      AppService().readCommentModelByDocIdVideo(docIdVideo: widget.docIdVideo);

      Map<String, dynamic> map =
          appController.videoModels[widget.indexVideo].toMap();
      int comment = appController.videoModels[widget.indexVideo].comment!;
      comment++;
      map['comment'] = comment;

      appController.videoModels[widget.indexVideo] = VideoModel.fromMap(map);

      FirebaseFirestore.instance
          .collection('video')
          .doc(widget.docIdVideo)
          .update(map);
    });
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({
    Key? key,
    required this.commentModel,
  }) : super(key: key);

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    var info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          commentModel.mapComment['name'],
          style: StandardTextStyle.smallWithOpacity,
        ),
        Container(height: 2),
        Text(
          commentModel.comment,
          style: StandardTextStyle.normal,
        ),
      ],
    );
    Widget right =  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          commentModel.upBool ? Icons.arrow_circle_up : Icons.arrow_circle_down,
          color: commentModel.upBool ? Colors.red : Colors.white,
        ),
       
      ],
    );
    right = Opacity(
      opacity: 1,
      child: right,
    );
    var avatar = Container(
      margin: EdgeInsets.fromLTRB(0, 8, 10, 8),
      child: Container(
        height: 36,
        width: 36,
        child: ClipOval(
          child: WidgetImageNetwork(
            urlImage: commentModel.mapComment['urlAvatar'],
            boxFit: BoxFit.cover,
          ),
        ),
      ),
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: <Widget>[
          avatar,
          Expanded(child: info),
          right,
        ],
      ),
    );
  }
}
