import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/pages/userDetailPage.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/views/bottom_sheet_authen.dart';
import 'package:xstream/views/remarkBottomSheet.dart';
import 'package:xstream/views/selectText.dart';
import 'package:xstream/views/widget_image.dart';
import 'package:xstream/views/widget_text.dart';

enum TikTokPageTag {
  home,
  remark,
  msg,
  me,
}

class TikTokTabBar extends StatelessWidget {
  final Function(TikTokPageTag)? onTabSwitch;
  final Function()? onAddButton;

  final bool hasBackground;
  final TikTokPageTag? current;

  const TikTokTabBar({
    Key? key,
    this.onTabSwitch,
    this.current,
    this.onAddButton,
    this.hasBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appController = Get.put(AppController());
    final EdgeInsets padding = MediaQuery.of(context).padding;
    Widget row = Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const WidgetImage(
                  path: 'images/tuktuk.png',size: 30,
                ),
                WidgetText(data: 'หน้าหลัก', textStyle: AppConstant().bodyStyle(fontSize: 12),)
              ],
            ),
            onTap: () => onTabSwitch?.call(TikTokPageTag.home),
          ),
        ),
        // Expanded(
        //   child: GestureDetector(
        //     child: SelectText(
        //       isSelect: current == TikTokPageTag.remark,
        //       title: 'เสนอแนะ',
        //     ),
        //     onTap: () {
        //       Get.bottomSheet(RemarkBottomSheet());

        //       // onTabSwitch?.call(TikTokPageTag.follow);
        //     },
        //   ),
        // ),
        Expanded(
          child: GestureDetector(
            child: const WidgetImage(
              path: 'images/plus.png',
              size: 38,
            ),
            onTap: () {
              onAddButton?.call();
              // Get.to(CameraPage());
            },
          ),
        ),
        // Expanded(
        //   child: GestureDetector(
        //     child: SelectText(
        //       isSelect: current == TikTokPageTag.msg,
        //       title: 'สินค้า',
        //     ),
        //     onTap: () {
        //       // onTabSwitch?.call(TikTokPageTag.msg);
        //     },
        //   ),
        // ),
        Expanded(
          child: GestureDetector(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const WidgetImage(
                  path: 'images/user.png',
                  size: 20,
                ),
                WidgetText(data: 'โปรไฟร์', textStyle: AppConstant().bodyStyle(fontSize: 12),)
              ],
            ),
            onTap: () {
              onTabSwitch?.call(TikTokPageTag.me);

              if (appController.currentUserModels.isNotEmpty) {
                Get.to(UserDetailPage());
              } else {
                Get.bottomSheet(
                  const BottomSheetAuthen(),
                  isScrollControlled: true,
                );
              }
            },
          ),
        ),
      ],
    );

    return Container(
      color: hasBackground ? ColorPlate.back2 : ColorPlate.back2.withOpacity(0),
      
      child: Container(
        padding: EdgeInsets.only(bottom: padding.bottom),
        height: 50 + padding.bottom,
        child: row,
      ),
    );
  }
}
