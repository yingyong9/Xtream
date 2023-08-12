// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tapped/tapped.dart';

import 'package:xstream/models/user_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/views/tilTokAppBar.dart';
import 'package:xstream/views/widget_image.dart';
import 'package:xstream/views/widget_image_network.dart';

class UserDetailOwnerVideo extends StatefulWidget {
  const UserDetailOwnerVideo({
    Key? key,
    required this.ownerVideoUserModel,
    this.displayBack,
  }) : super(key: key);

  @override
  _UserDetailOwnerVideoState createState() => _UserDetailOwnerVideoState();

  final UserModel ownerVideoUserModel;
  final bool? displayBack;
}

class _UserDetailOwnerVideoState extends State<UserDetailOwnerVideo> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    Widget head = TikTokAppbar(
      title: widget.ownerVideoUserModel.name,
      displayBack: widget.displayBack,
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
        InkWell(
          onTap: () {
            // Get.to(EditProfile());
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              '',
              style: StandardTextStyle.smallWithOpacity.apply(
                color: ColorPlate.orange,
              ),
            ),
          ),
        )
      ],
    );
    Widget body = ListView(
      padding: EdgeInsets.only(
        bottom: 80 + MediaQuery.of(context).padding.bottom,
      ),
      children: <Widget>[
        userHead,
        _UserInfoRow(
          icon: WidgetImageNetwork(
              urlImage: widget.ownerVideoUserModel.urlAvatar),
          rightIcon: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'รูปโปรไฟล์',
                style: StandardTextStyle.small,
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () async {},
        ),
        _UserInfoRow(
          title: 'ชื่อ',
          rightIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.ownerVideoUserModel.name,
                style: StandardTextStyle.small,
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () {},
        ),
        _UserInfoRow(
          title: 'Email',
          rightIcon: Row(
            children: [
              Text(
                widget.ownerVideoUserModel.email!,
                style: StandardTextStyle.small,
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () {},
        ),
        _UserInfoRow(
          icon: const WidgetImage(
            path: 'images/call.png',
            size: 24,
          ),
          rightIcon: Row(
            children: [
              Text(
                widget.ownerVideoUserModel.phoneContact ?? '',
                style: StandardTextStyle.small,
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () {},
        ),
        _UserInfoRow(
          icon: const WidgetImage(
            path: 'images/line.png',
            size: 24,
          ),
          rightIcon: Row(
            children: [
              Text(
                widget.ownerVideoUserModel.linkLine ?? '',
                style: StandardTextStyle.small,
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () {},
        ),
        _UserInfoRow(
          icon: const WidgetImage(
            path: 'images/tiktok.png',
            size: 24,
          ),
          rightIcon: Row(
            children: [
              Text(
                widget.ownerVideoUserModel.linktiktok ?? '',
                style: StandardTextStyle.small,
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () {},
        ),
        _UserInfoRow(
          icon: const WidgetImage(
            path: 'images/facebook.png',
            size: 24,
          ),
          rightIcon: Row(
            children: [
              Text(
                widget.ownerVideoUserModel.facebook ?? '',
                style: StandardTextStyle.small,
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () {},
        ),
        _UserInfoRow(
          icon: const WidgetImage(
            path: 'images/messaging.png',
            size: 24,
          ),
          rightIcon: Row(
            children: [
              Text(
                widget.ownerVideoUserModel.linkMessaging ?? '',
                style: StandardTextStyle.small,
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () {},
        ),
        _UserInfoRow(
          icon: const WidgetImage(
            path: 'images/lazada.png',
            size: 24,
          ),
          rightIcon: Row(
            children: [
              Text(
                widget.ownerVideoUserModel.lazada ?? '',
                style: StandardTextStyle.small,
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () {},
        ),
        _UserInfoRow(
          icon: const WidgetImage(
            path: 'images/shopee.png',
            size: 24,
          ),
          rightIcon: Row(
            children: [
              Text(
                widget.ownerVideoUserModel.shoppee ?? '',
                style: StandardTextStyle.small,
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () {},
        ),
        _UserInfoRow(
          icon: const WidgetImage(
            path: 'images/intragram.png',
            size: 24,
          ),
          rightIcon: Row(
            children: [
              Text(
                widget.ownerVideoUserModel.intagram ?? '',
                style: StandardTextStyle.small,
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () {},
        ),
        _UserInfoRow(
          icon: const WidgetImage(
            path: 'images/twitter.png',
            size: 24,
          ),
          rightIcon: Row(
            children: [
              Text(
                widget.ownerVideoUserModel.twitter ?? '',
                style: StandardTextStyle.small,
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          onTap: () {},
        ),
        // _UserInfoRow(
        //   title: 'Sign Out',
        //   rightIcon: const Row(
        //     children: [
        //       Text(
        //         'ออกจากระบบ',
        //         style: StandardTextStyle.big,
        //       ),
        //       Icon(Icons.arrow_forward_ios),
        //     ],
        //   ),
        //   onTap: () {
        //     AppService().processSignOut();
        //   },
        // ),
      ],
    );

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
    this.icon,
    this.title,
    this.rightIcon,
    this.onTap,
  });
  final Widget? icon;
  final Widget? rightIcon;
  final String? title;
  final Function()? onTap;

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
            opacity: 0.6,
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
