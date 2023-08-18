// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:xstream/pages/detail_post.dart';
import 'package:xstream/pages/homePage.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';

class CheckVideo extends StatefulWidget {
  const CheckVideo({
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
  State<CheckVideo> createState() => _CheckVideoState();
}

class _CheckVideoState extends State<CheckVideo> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();

    videoPlayerController = VideoPlayerController.file(widget.fileVideo)
      ..initialize().then((value) {
        videoPlayerController!.play();
      });

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      aspectRatio: 9 / 16,
      looping: true,
    );
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
      // appBar: AppBar(
      //   backgroundColor: ColorPlate.back1,
      //   leading: WidgetBackButton(
      //     pressFunc: () {
      //       Get.offAll(const HomePage());
      //     },
      //   ),
      //   elevation: 0,
      // ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return Stack(
          children: [
            SizedBox(
              width: boxConstraints.maxWidth,
              height: boxConstraints.maxHeight - 80,
              child: FittedBox(
                child: Chewie(controller: chewieController!),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 24,
              child: WidgetBackButton(color: Colors.black,
                pressFunc: () {
                  Get.offAll(const HomePage());
                },
              ),
            )
          ],
        );
      }),
      bottomSheet: Container(
        decoration: const BoxDecoration(color: Colors.black),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            WidgetButton(
              label: 'ถัดไป',
              pressFunc: () {
                 Get.offAll(DetailPost(
            fileThumbnail: widget.fileThumbnail,
            fileVideo: widget.fileVideo,
            nameFileVideo: widget.nameFileVideo,
            nameFileImage: widget.nameFileImage));
              },
              color: ColorPlate.red,
            ),
            const SizedBox(
              width: 16,
            )
          ],
        ),
      ),
    );
  }
}
