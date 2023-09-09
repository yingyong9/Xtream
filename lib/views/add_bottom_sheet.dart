import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/pages/watch_live_video.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_icon_button.dart';
import 'package:xstream/views/widget_text.dart';

class AddBottomSheet extends StatelessWidget {
  const AddBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: ColorPlate.back1,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WidgetIconButton(
                    iconData: Icons.video_call,
                    size: 48,
                    pressFunc: () {
                      Get.back();
                      AppService().processUploadVideoFromGallery();
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const WidgetText(data: 'Add Video')
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WidgetIconButton(
                    iconData: Icons.tv,
                    size: 48,
                    pressFunc: () {
                      Get.back();
                      Get.to(const WatchLiveVideo());
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const WidgetText(data: 'Watch Live')
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
