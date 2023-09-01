// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tapped/tapped.dart';

import 'package:xstream/models/video_model.dart';
import 'package:xstream/pages/easy_edit_profile.dart';
import 'package:xstream/pages/list_invoid.dart';
import 'package:xstream/pages/list_order.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/tilTokAppBar.dart';
import 'package:xstream/views/widget_image.dart';
import 'package:xstream/views/widget_image_network.dart';

class DisplayProfileTapIcon extends StatefulWidget {
  @override
  _DisplayProfileTapIconState createState() => _DisplayProfileTapIconState();

  final VideoModel videoModel;
  const DisplayProfileTapIcon({
    Key? key,
    required this.videoModel,
  }) : super(key: key);
}

class _DisplayProfileTapIconState extends State<DisplayProfileTapIcon> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().readAllOrder();
    AppService().readAllInvoid();
  }

  @override
  Widget build(BuildContext context) {
    Widget head = TikTokAppbar(
      title: widget.videoModel.mapUserModel['name'],
    );

    var userHead = Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: const Text(
              'ข้อมูลส่วนตัว',
              style: StandardTextStyle.smallWithOpacity,
            ),
          ),
        ),
      ],
    );
    Widget body = Obx(() {
      return appController.currentUserModels.isEmpty
          ? const SizedBox()
          : ListView(
              padding: EdgeInsets.only(
                bottom: 80 + MediaQuery.of(context).padding.bottom,
              ),
              children: <Widget>[
                userHead,
                _UserInfoRow(
                  icon: WidgetImageNetwork(
                      urlImage: widget.videoModel.mapUserModel['urlAvatar']),
                  rightIcon: const Text(
                    'รูปโปรไฟร์',
                    style: StandardTextStyle.small,
                  ),
                ),
                _UserInfoRow(
                  title: 'ชื่อ',
                  rightIcon: Text(
                    widget.videoModel.mapUserModel['name'],
                    style: StandardTextStyle.normal,
                  ),
                ),
                widget.videoModel.priceProduct!.isEmpty
                    ? const SizedBox()
                    : _UserInfoRow(
                        title: 'Comment ร้านค้า',
                        rightIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(),
                              child: const Text(
                                '',
                                style: StandardTextStyle.small,
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                        onTap: () {},
                      ),
                _UserInfoRow(
                  title: 'แซต',
                  rightIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        child: const Text(
                          '',
                          style: StandardTextStyle.small,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {},
                ),
                _UserInfoRow(
                  title: 'วีดีโอทั้งหมด',
                  rightIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(),
                        child: const Text(
                          '',
                          style: StandardTextStyle.small,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {},
                ),
                widget.videoModel.mapUserModel['email'].isEmpty
                    ? const SizedBox()
                    : _UserInfoRow(
                        title: 'Email',
                        rightIcon: Text(
                          widget.videoModel.mapUserModel['email'],
                          style: StandardTextStyle.small,
                        ),
                      ),
                widget.videoModel.mapUserModel['phoneContact'].isEmpty
                    ? const SizedBox()
                    : _UserInfoRow(
                        icon: const WidgetImage(
                          path: 'images/call.png',
                          size: 24,
                        ),
                        rightIcon: Text(
                          appController.currentUserModels.last.phoneContact ??
                              '',
                          style: StandardTextStyle.small,
                        ),
                      ),
                widget.videoModel.mapUserModel['linkLine'].isEmpty ? const SizedBox() : _UserInfoRow(
                  icon: const WidgetImage(
                    path: 'images/line.png',
                    size: 24,
                  ),
                  rightIcon: Text(
                    widget.videoModel.mapUserModel['linkLine'],
                    style: StandardTextStyle.small,
                  ),
                 
                ),
                _UserInfoRow(
                  icon: WidgetImage(
                    path: 'images/tiktok.png',
                    size: 24,
                  ),
                  rightIcon: Row(
                    children: [
                      Text(
                        appController.currentUserModels.last.linktiktok ?? '',
                        style: StandardTextStyle.small,
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    Get.to(EasyEditProfile(
                      title: 'Your Tiktok',
                      text:
                          appController.currentUserModels.last.linktiktok ?? '',
                      keyMap: 'linktiktok',
                    ));
                  },
                ),
                _UserInfoRow(
                  icon: WidgetImage(
                    path: 'images/facebook.png',
                    size: 24,
                  ),
                  rightIcon: Row(
                    children: [
                      Text(
                        appController.currentUserModels.last.facebook ?? '',
                        style: StandardTextStyle.small,
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    Get.to(EasyEditProfile(
                      title: 'Your Facebook',
                      text: appController.currentUserModels.last.facebook!,
                      keyMap: 'facebook',
                    ));
                  },
                ),
                _UserInfoRow(
                  icon: WidgetImage(
                    path: 'images/messaging.png',
                    size: 24,
                  ),
                  rightIcon: Row(
                    children: [
                      Text(
                        appController.currentUserModels.last.linkMessaging ??
                            '',
                        style: StandardTextStyle.small,
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    Get.to(EasyEditProfile(
                      title: 'Your Messaging',
                      text: appController.currentUserModels.last.linkMessaging!,
                      keyMap: 'linkMessaging',
                    ));
                  },
                ),
                _UserInfoRow(
                  icon: WidgetImage(
                    path: 'images/lazada.png',
                    size: 24,
                  ),
                  rightIcon: Row(
                    children: [
                      Text(
                        appController.currentUserModels.last.lazada ?? '',
                        style: StandardTextStyle.small,
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    Get.to(EasyEditProfile(
                      title: 'Your Lazada',
                      text: appController.currentUserModels.last.lazada!,
                      keyMap: 'lazada',
                    ));
                  },
                ),
                _UserInfoRow(
                  icon: WidgetImage(
                    path: 'images/shopee.png',
                    size: 24,
                  ),
                  rightIcon: Row(
                    children: [
                      Text(
                        appController.currentUserModels.last.shoppee ?? '',
                        style: StandardTextStyle.small,
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    Get.to(EasyEditProfile(
                      title: 'Your Shopee',
                      text: appController.currentUserModels.last.shoppee!,
                      keyMap: 'shoppee',
                    ));
                  },
                ),
                _UserInfoRow(
                  icon: WidgetImage(
                    path: 'images/intragram.png',
                    size: 24,
                  ),
                  rightIcon: Row(
                    children: [
                      Text(
                        appController.currentUserModels.last.intagram ?? '',
                        style: StandardTextStyle.small,
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    Get.to(EasyEditProfile(
                      title: 'Your Intagram',
                      text: appController.currentUserModels.last.intagram!,
                      keyMap: 'intagram',
                    ));
                  },
                ),
                _UserInfoRow(
                  icon: WidgetImage(
                    path: 'images/twitter.png',
                    size: 24,
                  ),
                  rightIcon: Row(
                    children: [
                      Text(
                        appController.currentUserModels.last.twitter ?? '',
                        style: StandardTextStyle.small,
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    Get.to(EasyEditProfile(
                      title: 'Your twitter',
                      text: appController.currentUserModels.last.twitter!,
                      keyMap: 'twitter',
                    ));
                  },
                ),
                _UserInfoRow(
                  title: 'Sign Out',
                  rightIcon: Row(
                    children: [
                      Text(
                        'ออกจากระบบ',
                        style: StandardTextStyle.big,
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () {
                    AppService().processSignOut();
                  },
                ),
              ],
            );
    });
    body = Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: body,
      ),
    );
    return Scaffold(
      body: Container(
        color: ColorPlate.back1,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            head,
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  _UserInfoRow({
    Key? key,
    this.icon,
    this.rightIcon,
    this.title,
    this.onTap,
    this.opacity,
  }) : super(key: key);
  final Widget? icon;
  final Widget? rightIcon;
  final String? title;
  final Function()? onTap;
  final double? opacity;

  @override
  Widget build(BuildContext context) {
    Widget iconImg = Container(
      height: 30,
      width: 30,
      child: icon,
    );

    Widget row = Container(
      height: 48,
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: Border(
          bottom: BorderSide(color: Colors.white12),
        ),
      ),
      child: Row(
        children: <Widget>[
          icon != null ? iconImg : const SizedBox(),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12),
              child: title == null
                  ? const SizedBox()
                  : Text(
                      title!,
                      style: TextStyle(fontSize: 14),
                    ),
            ),
          ),
          Opacity(
            opacity: opacity ?? 0.6,
            child: rightIcon ??
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                ),
          ),
        ],
      ),
    );
    row = Tapped(
      onTap: onTap,
      child: row,
    );

    return row;
  }
}
