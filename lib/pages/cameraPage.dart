// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:tapped/tapped.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/tikTokVideoButtonColumn.dart';



class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    print(
        'currentUserModel ---> ${appController.currentUserModels.last.toMap()}');
  }

  @override
  Widget build(BuildContext context) {
    Widget rightButtons = const Column(
      children: <Widget>[
        _CameraIconButton(
          icon: Icons.repeat,
          title: '11',
        ),
        _CameraIconButton(
          icon: Icons.tonality,
          title: '22',
        ),
        _CameraIconButton(
          icon: Icons.texture,
          title: '22',
        ),
        _CameraIconButton(
          icon: Icons.sentiment_satisfied,
          title: '44',
        ),
        _CameraIconButton(
          icon: Icons.timer,
          title: '55',
        ),
      ],
    );

    rightButtons = Opacity(
      opacity: 0.8,
      child: Container(
        padding: const EdgeInsets.only(right: 20, top: 12),
        alignment: Alignment.topRight,
        child: Container(
          child: rightButtons,
        ),
      ),
    );

    Widget selectMusic = Container(
      padding: const EdgeInsets.only(left: 20, top: 20),
      alignment: Alignment.topCenter,
      child: DefaultTextStyle(
        style: TextStyle(
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0, 1),
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const IconToText(
              Icons.music_note,
            ),
            const Text(
              'AAAA',
              style: StandardTextStyle.normal,
            ),
            Container(width: 32, height: 12),
          ],
        ),
      ),
    );

    var closeButton = Tapped(
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 20),
        alignment: Alignment.topLeft,
        child: Container(
          child: Icon(Icons.clear),
        ),
      ),
      onTap: Navigator.of(context).pop,
    );

    var cameraButton = Container(
      padding: EdgeInsets.only(bottom: 12),
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _SidePhotoButton(title: 'AA'),
            Expanded(
              child: Center(
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.white.withOpacity(0.4),
                      width: 6,
                    ),
                  ),
                ),
              ),
            ),
            _SidePhotoButton(
              title: 'อัพโหลด',
              tapFunc: () {
                print('You tap');
                AppService().processUploadVideoFromGallery();
              },
            ),
          ],
        ),
      ),
    );

    var body = Stack(
      fit: StackFit.expand,
      children: <Widget>[
        cameraButton,
        // closeButton,

        selectMusic,
        rightButtons,
      ],
    );

    return Scaffold(
      // backgroundColor: Color(0xFFf5f5f4),
      body: SafeArea(
        child: body,
        // child: WidgetText(data: 'data'),
      ),
    );
  }
}

class _SidePhotoButton extends StatelessWidget {
  final String? title;
  final Function()? tapFunc;
  const _SidePhotoButton({
    Key? key,
    this.title,
    this.tapFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tapFunc,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                style: BorderStyle.solid,
                color: Colors.white.withOpacity(0.4),
                width: 2,
              ),
            ),
          ),
          Container(height: 2),
          Text(
            title!,
            style: StandardTextStyle.smallWithOpacity,
          )
        ],
      ),
    );
  }
}

class _CameraIconButton extends StatelessWidget {
  final IconData? icon;
  final String? title;
  const _CameraIconButton({
    Key? key,
    this.icon,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: DefaultTextStyle(
        style: TextStyle(shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.15),
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ]),
        child: Column(
          children: <Widget>[
            IconToText(
              icon,
            ),
            Text(
              title!,
              style: StandardTextStyle.small,
            ),
          ],
        ),
      ),
    );
  }
}
