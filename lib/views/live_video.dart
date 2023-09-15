// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:xstream/models/video_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/views/tikTokVideoGesture.dart';
import 'package:xstream/views/widget_avatar.dart';

///
class LiveVideo extends StatelessWidget {
  final Widget? video;
  final double aspectRatio;
  final String? tag;
  final double bottomPadding;

  final Widget? rightButtonColumn;
  final Widget? userInfoWidget;

  final bool hidePauseIcon;

  final Function? onAddFavorite;
  final Function? onSingleTap;

  const LiveVideo({
    Key? key,
    this.bottomPadding = 16,
    this.tag,
    this.rightButtonColumn,
    this.userInfoWidget,
    this.onAddFavorite,
    this.onSingleTap,
    this.video,
    this.aspectRatio = 9 / 16.0,
    this.hidePauseIcon = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget rightButtons = rightButtonColumn ?? Container();

    Widget userInfo = userInfoWidget ??
        VideoUserInfo(
          bottomPadding: bottomPadding, tapProfileFunction: () {  },
        );

    Widget videoContainer = Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          alignment: Alignment.center,
          child: Container(
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: video,
            ),
          ),
        ),
        TikTokVideoGesture(
          onAddFavorite: onAddFavorite,
          onSingleTap: onSingleTap,
          child: Container(
            color: ColorPlate.clear,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        hidePauseIcon
            ? Container()
            : Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_circle_outline,
                  size: 120,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
      ],
    );
    Widget body = Container(
      child: Stack(
        children: <Widget>[
          videoContainer,
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomRight,
            child: rightButtons,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            child: userInfo,
          ),
        ],
      ),
    );
    return body;
  }
}

class VideoLoadingPlaceHolder extends StatelessWidget {
  const VideoLoadingPlaceHolder({
    Key? key,
    required this.tag,
  }) : super(key: key);

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: <Color>[
            Colors.blue,
            Colors.green,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitWave(
            size: 36,
            color: Colors.white.withOpacity(0.3),
          ),
          Container(
            padding: const EdgeInsets.all(50),
            child: Text(
              tag,
              style: StandardTextStyle.normalWithOpacity,
            ),
          ),
        ],
      ),
    );
  }
}

class VideoUserInfo extends StatelessWidget {
  final String? desc;
  final VideoModel? videoModel;

  const VideoUserInfo({
    Key? key,
    this.desc,
    this.videoModel,
    required this.bottomPadding,
    required this.tapProfileFunction,
  }) : super(key: key);

  final double bottomPadding;
  final Function() tapProfileFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        bottom: bottomPadding,
      ),
      margin: const EdgeInsets.only(right: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              InkWell(
                onTap: tapProfileFunction,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WidgetAvatar(
                      urlImage: videoModel!.mapUserModel['urlAvatar'],
                      size: 48,
                    ),
                    Text(
                      videoModel == null
                          ? ''
                          : ' @${videoModel!.mapUserModel["name"]}',
                      style: AppConstant().bodyStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(height: 6),
          // Text(
          //   desc ?? '',
          //   style: StandardTextStyle.normal,
          // ),
          ExpandableText(
            videoModel!.detail ?? '',
            expandText: 'ดูเพิ่มเติม',
            linkStyle: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            collapseText: 'ซ่อน',
            maxLines: 3,
            style: AppConstant()
                .bodyStyle(fontWeight: FontWeight.bold, fontSize: SysSize.big),
          ),
          Container(height: 6),
          // const Row(
          //   children: <Widget>[
          //     Icon(Icons.music_note, size: 14),
          //     Expanded(
          //       child: Text(
          //         'คำอธิบาย ???',
          //         maxLines: 9,
          //         style: StandardTextStyle.normal,
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
