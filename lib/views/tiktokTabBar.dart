
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/views/selectText.dart';

enum TikTokPageTag {
  home,
  follow,
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
        // Expanded(
        //   child: GestureDetector(
        //     child: SelectText(
        //       isSelect: current == TikTokPageTag.follow,
        //       title: 'Follow',
        //     ),
        //     onTap: () => onTabSwitch?.call(TikTokPageTag.follow),
        //   ),
        // ),
        Expanded(
          child: GestureDetector(
            child: Icon(
              Icons.add_box,
              size: 32,
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
        //       title: 'Message',
        //     ),
        //     onTap: () => onTabSwitch?.call(TikTokPageTag.msg),
        //   ),
        // ),
        Expanded(
          child: GestureDetector(
            child: SelectText(
              isSelect: current == TikTokPageTag.me,
              title: 'Profile',
            ),
            onTap: () => onTabSwitch?.call(TikTokPageTag.me),
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
