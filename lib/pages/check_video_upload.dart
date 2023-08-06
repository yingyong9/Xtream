// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:xstream/pages/detail_post.dart';
import 'package:xstream/views/widget_button.dart';



class CheckVideoUpload extends StatefulWidget {
  const CheckVideoUpload({
    Key? key,
    required this.fileThumbnail,
    required this.fileVideo,
    required this.nameFileVideo,
    required this.nameFileImage,
  }) : super(key: key);

  final File fileThumbnail;
  final File fileVideo;
  final String nameFileVideo;
  final String nameFileImage;

  @override
  State<CheckVideoUpload> createState() => _CheckVideoUploadState();
}

class _CheckVideoUploadState extends State<CheckVideoUpload> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.file(widget.fileVideo)
      ..initialize()
      ..play();
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        aspectRatio: 9 / 16,
        looping: true);
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return Column(
          children: [
            SizedBox(
              width: boxConstraints.maxWidth,
              height: boxConstraints.maxHeight - 48,
              child: Chewie(controller: chewieController!),
            ),
            bottomPanal(boxConstraints: boxConstraints),
          ],
        );
      }),
    );
  }

  Widget bottomPanal({required BoxConstraints boxConstraints}) {
    return Positioned(
      bottom: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: boxConstraints.maxWidth * 0.5 - 16,
            child: WidgetButton(
              label: 'ยกเลิก',
              pressFunc: () {
                Get.back();
              },
            ),
          ),
          SizedBox(
            width: boxConstraints.maxWidth * 0.5 - 16,
            child: WidgetButton(
              color: Colors.red.shade700,
              // label: 'โฟสต์',
              label: 'ต่อไป',
              pressFunc: () {
                Get.offAll(DetailPost(
                  fileThumbnail: widget.fileThumbnail,
                  fileVideo: widget.fileVideo,
                  nameFileImage: widget.nameFileImage,
                  nameFileVideo: widget.nameFileVideo,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
