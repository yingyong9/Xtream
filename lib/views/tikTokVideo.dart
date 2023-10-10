// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:xstream/models/video_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/views/tikTokVideoGesture.dart';
import 'package:xstream/views/widget_avatar.dart';
import 'package:xstream/views/widget_text.dart';

///
class TikTokVideoPage extends StatelessWidget {
  final Widget? video;
  final double aspectRatio;
  final String? tag;
  final double bottomPadding;

  final Widget? rightButtonColumn;
  final Widget? userInfoWidget;
  final Widget? commentButton;

  final bool hidePauseIcon;

  final Function? onAddFavorite;
  final Function? onSingleTap;

  const TikTokVideoPage({
    Key? key,
    this.video,
    this.aspectRatio = 9 / 16.0,
    this.tag,
    this.bottomPadding = 16,
    this.rightButtonColumn,
    this.userInfoWidget,
    this.commentButton,
    this.hidePauseIcon = false,
    this.onAddFavorite,
    this.onSingleTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget rightButtons = rightButtonColumn ?? Container();

    Widget userInfo = userInfoWidget ??
        VideoUserInfo(
          bottomPadding: bottomPadding,
          tapProfileFunction: () {},
          reviewWidget: commentButton,
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
  final Widget? reviewWidget;

  const VideoUserInfo({
    Key? key,
    this.desc,
    this.videoModel,
    this.reviewWidget,
    required this.bottomPadding,
    required this.tapProfileFunction,
  }) : super(key: key);

  final double bottomPadding;
  final Function() tapProfileFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,right: 12,
        // bottom: bottomPadding,
      ),
      // margin: const EdgeInsets.only(right: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          reviewWidget ?? const SizedBox(),
          Container(height: 6),
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
        ],
      ),
    );
  }
}
