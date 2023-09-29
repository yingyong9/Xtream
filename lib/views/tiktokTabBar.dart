import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/pages/authen.dart';
import 'package:xstream/pages/userDetailPage.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/views/chat_comment_bottomsheet.dart';
import 'package:xstream/views/commentShopBottomSheet.dart';
import 'package:xstream/views/remarkBottomSheet.dart';
import 'package:xstream/views/selectText.dart';
import 'package:xstream/views/widget_button.dart';

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
            child: SelectText(
              isSelect: current == TikTokPageTag.home,
              title: 'Home',
            ),
            onTap: () => onTabSwitch?.call(TikTokPageTag.home),
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == TikTokPageTag.remark,
              title: 'เสนอแนะ',
            ),
            onTap: () {
              Get.bottomSheet(RemarkBottomSheet());

              // onTabSwitch?.call(TikTokPageTag.follow);
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: const Icon(
              Icons.add_box,
              size: 32,
            ),
            onTap: () {
              onAddButton?.call();
              // Get.to(CameraPage());
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == TikTokPageTag.msg,
              title: 'สินค้า',
            ),
            onTap: () {
              // onTabSwitch?.call(TikTokPageTag.msg);
            },
          ),
        ),
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == TikTokPageTag.me,
              title: 'Profile',
            ),
            onTap: () {
              onTabSwitch?.call(TikTokPageTag.me);

              if (appController.currentUserModels.isNotEmpty) {
                Get.to(UserDetailPage());
              } else {
                Get.to(const Authen());
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
        height: 150 + padding.bottom,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(margin: const EdgeInsets.only(left: 20),
              child: WidgetButton(
                label: 'แสดงความคิดเห็น ...',
                pressFunc: () {
                  Get.bottomSheet(ChatCommentBottomSheet());
                },
                color: ColorPlate.back1.withOpacity(0.5),
              ),
            ),
            row,
          ],
        ),
      ),
    );
  }
}
