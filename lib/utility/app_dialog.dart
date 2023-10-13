import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xstream/models/video_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/views/widget_avatar.dart';
import 'package:xstream/views/widget_image.dart';
import 'package:xstream/views/widget_progress.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';

class AppDialog {
  void dialogProgress() {
    Get.dialog(WillPopScope(
      child: WidgetProgress(),
      onWillPop: ()async {
        return false;
      },
    ));
  }

  void dialogShowUser(
      {required BuildContext context,
      required VideoModel videoModel,
      String? title}) {
    Get.dialog(AlertDialog(
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              title == null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WidgetAvatar(
                            urlImage: videoModel.mapUserModel['urlAvatar']),
                        title == null
                            ? WidgetText(data: videoModel.mapUserModel['name'])
                            : const SizedBox(),
                      ],
                    )
                  : Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: WidgetText(
                        data: title,
                        textStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
            ],
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const WidgetImage(
                path: 'images/call.png',
                size: 36,
              ),
              const SizedBox(
                width: 16,
              ),
              WidgetText(data: videoModel.mapUserModel['phoneContact']),
            ],
          ),
          Row(
            children: [
              const WidgetImage(
                path: 'images/line.png',
                size: 36,
              ),
              const SizedBox(
                width: 16,
              ),
              WidgetText(data: videoModel.mapUserModel['linkLine']),
            ],
          ),
          Row(
            children: [
              WidgetImage(
                path: 'images/messaging.png',
                size: 36,
              ),
              const SizedBox(
                width: 16,
              ),
              WidgetText(data: videoModel.mapUserModel['linkMessaging']),
            ],
          ),
        ],
      ),
    ));
  }

  void normalDialog({
    Widget? icon,
    Widget? title,
    Widget? content,
    Widget? firstAction,
    Widget? secondAction,
    AlignmentGeometry? alignmentGeometry,
  }) {
    Get.dialog(
      AlertDialog(
        alignment: alignmentGeometry,
        backgroundColor: ColorPlate.back2,
        icon: icon,
        title: title,
        content: content,
        actions: [
          firstAction ??
              WidgetTextButton(
                label: 'Cancel',
                pressFunc: () {
                  Get.back();
                },
              ), secondAction ?? const SizedBox(),
        ],
      ),barrierDismissible: false
    );
  }
}
