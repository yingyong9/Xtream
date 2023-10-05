// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:restart_app/restart_app.dart';
// import 'package:safemap/safemap.dart';
import 'package:video_player/video_player.dart';
import 'package:xstream/controller/tikTokVideoListController.dart';
import 'package:xstream/models/user_model.dart';
import 'package:xstream/models/video_model.dart';

// import 'package:xstream/other/bottomSheet.dart' as CustomBottomSheet;
import 'package:xstream/pages/authen.dart';
import 'package:xstream/pages/display_profile_tap_icon.dart';
import 'package:xstream/pages/list_live.dart';
import 'package:xstream/pages/searchPage.dart';
import 'package:xstream/pages/userDetailOwnerVideo.dart';
import 'package:xstream/style/physics.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/utility/app_snackbar.dart';
import 'package:xstream/views/chat_comment_bottomsheet.dart';
import 'package:xstream/views/product_bottomSheet.dart';
import 'package:xstream/views/tikTokCommentBottomSheet.dart';
import 'package:xstream/views/tikTokHeader.dart';
import 'package:xstream/views/tikTokScaffold.dart';
import 'package:xstream/views/tikTokVideo.dart';
import 'package:xstream/views/tikTokVideoButtonColumn.dart';
import 'package:xstream/views/tiktokTabBar.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_icon_button_gf.dart';

import 'package:xstream/views/widget_progress.dart';
import 'package:xstream/views/widget_web_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  TikTokPageTag tabBarType = TikTokPageTag.home;

  TikTokScaffoldController tkController = TikTokScaffoldController();

  final PageController _pageController = PageController();

  TikTokVideoListController _videoListController = TikTokVideoListController();

  Map<int, bool> favoriteMap = {};

  List<VideoModel> videoDataList = [];

  AppController appController = Get.put(AppController());

  double? screenHeight;

  bool first = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state != AppLifecycleState.resumed) {
      _videoListController.currentPlayer.pause();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _videoListController.currentPlayer.pause();
    super.dispose();
  }

  @override
  void initState() {
    // Wakelock.enable().then((value) {
    //   print('##3oct WakeLock Enable');
    // });

    AppService().findCurrentUserModel().then((value) {
      if (appController.currentUserModels.isNotEmpty) {
        AppService().aboutNoti();
      }
    });

    homePageLoadVideo();

    super.initState();
  }

  void homePageLoadVideo() {
    if (videoDataList.isNotEmpty) {
      videoDataList.clear();
    }

    AppService().readAllVideo().then((value) {
      // videoDataList = appController.videoModels;
      videoDataList.addAll(appController.videoModels);

      AppService().listenChatComment(docIdVideo: appController.docIdVideos[0]);

      WidgetsBinding.instance.addObserver(this);
      _videoListController.init(
        pageController: _pageController,
        initialList: videoDataList
            .map(
              (e) => VPVideoController(
                videoInfo: e,
                builder: () => VideoPlayerController.network(e.url),
              ),
            )
            .toList(),
        videoProvider: (int index, List<VPVideoController> list) async {
          return videoDataList
              .map(
                (e) => VPVideoController(
                  videoInfo: e,
                  builder: () => VideoPlayerController.network(e.url),
                ),
              )
              .toList();
        },
      );
      _videoListController.addListener(() {
        setState(() {});
      });
      tkController.addListener(
        () {
          print('listener Work');
          if (tkController.value == TikTokPagePositon.middle) {
            _videoListController.currentPlayer.play();
          } else {
            _videoListController.currentPlayer.pause();
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    print('#### screenHeight --> $screenHeight');
    if (first) {
      first = false;
      appController.screenHeights.add(screenHeight!);
    }

    switch (tabBarType) {
      case TikTokPageTag.home:
        break;
      default:
    }
    double a = MediaQuery.of(context).size.aspectRatio;
    bool hasBottomPadding = a < 0.55;

    bool hasBackground = hasBottomPadding;
    hasBackground = tabBarType != TikTokPageTag.home;
    if (hasBottomPadding) {
      hasBackground = true;
    }

    //ส่วนของ Bottom Navigator
    Widget tikTokTabBar = TikTokTabBar(
      hasBackground: hasBackground,
      current: tabBarType,
      onTabSwitch: (type) async {
        if (appController.currentUserModels.isEmpty) {
          _videoListController.currentPlayer.pause();
          Get.to(const Authen());
        } else {
          setState(() {
            tabBarType = type;
            if (type == TikTokPageTag.home) {
              _videoListController.currentPlayer.play();
            } else {
              _videoListController.currentPlayer.pause();
            }
          });
        }
      },
      onAddButton: () {
        _videoListController.currentPlayer.pause();

        if (appController.currentUserModels.isEmpty) {
          Get.to(const Authen());
        } else {
          // Get.bottomSheet(const AddBottomSheet());

          //ไปเปิด state เลือกวีดีโอ
          AppService().processUploadVideoFromGallery();
        }
      },
    );

    // var userPage = UserPage(
    //   isSelfPage: false,
    //   canPop: true,
    //   onPop: () {
    //     tkController.animateToMiddle();
    //   },
    // );
    var searchPage = SearchPage(
      onPop: tkController.animateToMiddle,
    );

    //ส่วนของหัวด้านบน
    var header = tabBarType == TikTokPageTag.home
        ? TikTokHeader(
            onSearch: () {
              tkController.animateToLeft();
            },
            onLive: () {
              _videoListController.currentPlayer.pause();
              Get.to(const ListLive())!.then((value) {
                _videoListController.currentPlayer.play();
              });
            },
          )
        : Container();

    return Obx(() {
      return appController.videoModels.isEmpty
          ? const WidgetProgress()
          : TikTokScaffold(
              controller: tkController,
              hasBottomPadding: hasBackground,
              tabBar: tikTokTabBar,
              header: header,
              leftPage: searchPage,
              // commentForm: commentButton(),
              rightPage: UserDetailOwnerVideo(
                ownerVideoUserModel: UserModel.fromMap(appController
                    .videoModels[appController.indexVideo.value].mapUserModel),
                displayBack: false,
              ),
              enableGesture: tabBarType == TikTokPageTag.home,
              page: Stack(
                children: <Widget>[
                  PageView.builder(
                    key: const Key('home'),
                    physics: const QuickerScrollPhysics(),
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: _videoListController.videoCount,
                    itemBuilder: (context, i) {
                      // bool isF = SafeMap(favoriteMap)[i].boolean;
                      bool isF = false;
                      var player = _videoListController.playerOfIndex(i)!;
                      var data = player.videoInfo!;

                      //ส่วนของ Button ด้านข้าง
                      Widget buttons = TikTokButtonColumn(
                        isFavorite: isF,
                        onAvatar: () {
                          UserModel userModel = UserModel.fromMap(
                              appController.videoModels[i].mapUserModel);

                          _videoListController.currentPlayer.pause();

                          if (appController.currentUserModels.isEmpty) {
                            Get.to(const Authen());
                          } else {
                            Get.to(UserDetailOwnerVideo(
                              ownerVideoUserModel: userModel,
                            ));
                          }
                        },
                        onDisplayImageProduct: () {
                          _videoListController.currentPlayer.pause();

                          // UserModel ownerVideoUserModel = UserModel.fromMap(
                          //     appController.videoModels[i].mapUserModel);

                          if (appController.currentUserModels.isEmpty) {
                            Get.to(const Authen());
                          } else {
                            if (appController
                                .videoModels[i].priceProduct!.isEmpty) {
                              Get.bottomSheet(
                                TikTokCommentBottomSheet(
                                  docIdVideo: appController.docIdVideos[i],
                                  indexVideo: i,
                                ),
                              );
                            } else {
                              appController.amount.value = 1;
                              Get.bottomSheet(ProductButtonSheet(
                                indexVideo: i,
                              ));
                            }
                          }
                        },
                        onTapImageLive: () {
                          print('You tap Imagd Live');

                          if (AppService().checkTimeLive(
                              startLive: appController
                                  .videoModels[appController.indexVideo.value]
                                  .startLive!)) {
                            //Live

                            _videoListController.currentPlayer.pause();

                            Get.to(WidgetWebView(
                                    streamKey: appController
                                        .videoModels[
                                            appController.indexVideo.value]
                                        .uidPost
                                        .substring(0, 6)))!
                                .then((value) {
                              _videoListController.currentPlayer.play();
                            });
                          } else {
                            AppSnackBar(
                                    title: 'Live สิ้นสุดแล้ว',
                                    message: 'ขออภัย Live สิ้นสุดแล้ว')
                                .errorSnackBar();
                          }
                        },
                        onFavorite: () {
                          setState(() {
                            favoriteMap[i] = !isF;
                          });
                          // showAboutDialog(context: context);
                        },
                        onComment: () {
                          Get.bottomSheet(
                            TikTokCommentBottomSheet(
                              docIdVideo: appController.docIdVideos[i],
                              indexVideo: i,
                            ),
                          );
                        },
                        onShare: () {},
                        onAddButton: () {
                          print(
                              'onAddButton Work at uid ของคนที่กด --> ${appController.currentUserModels.last.uid}');
                          print(
                              'onAddButton Work at uid ของคนที่จะไปอยู่ด้วย --> ${appController.videoModels[i].mapUserModel['uid']}');

                          AppService().processAddLoginToFriend(
                              mapFriendModel:
                                  appController.videoModels[i].mapUserModel);
                        },
                        videoModel: i < appController.videoModels.length
                            ? appController.videoModels[i]
                            : appController.videoModels.last,
                        docIdVideo: appController.docIdVideos[i],
                        indexVideo: i,
                      );

                      // video
                      Widget currentVideo = SingleChildScrollView(
                        child: Column(
                          children: [
                            Obx(() {
                              return appController.screenHeights.isEmpty
                                  ? const SizedBox()
                                  : SizedBox(
                                      height: appController.screenHeights.last,
                                      child: AspectRatio(
                                        aspectRatio:
                                            player.controller.value.aspectRatio,
                                        child: VideoPlayer(player.controller),
                                      ),
                                    );
                            }),
                          ],
                        ),
                      );

                      currentVideo = TikTokVideoPage(
                        hidePauseIcon: !player.showPauseIcon.value,
                        aspectRatio: 9 / 16.0,
                        key: Key(data.url + '$i'),
                        tag: data.url,
                        bottomPadding: hasBottomPadding ? 16.0 : 16.0,
                        commentButton: commentButton(),
                        userInfoWidget: VideoUserInfo(
                          desc: data.desc,
                          bottomPadding: hasBottomPadding ? 16.0 : 50.0,
                          videoModel: i < appController.videoModels.length
                              ? appController.videoModels[i]
                              : appController.videoModels.last,
                          tapProfileFunction: () {
                            print('you tab -->');
                            player.pause();
                            Get.to(DisplayProfileTapIcon(
                              videoModel: appController.videoModels[i],
                            ));
                          },
                          commentButton: commentButton(),
                        ),
                        onSingleTap: () async {
                          if (player.controller.value.isPlaying) {
                            await player.pause();
                          } else {
                            await player.play();
                          }
                          setState(() {});
                        },
                        onAddFavorite: () {
                          setState(() {
                            favoriteMap[i] = true;
                          });
                        },
                        rightButtonColumn: buttons,
                        video: currentVideo,
                      );
                      return currentVideo;
                    },
                    onPageChanged: (value) {
                      print('##29sep value =======> $value');

                      if (appController.chatCommentModels.isNotEmpty) {
                        appController.chatCommentModels.clear();
                      }

                      AppService().listenChatComment(
                          docIdVideo: appController.docIdVideos[value]);

                      if (value == 0) {
                        print('##4aug homePageVideo work');

                        if (Platform.isAndroid) {
                          Restart.restartApp();
                        }
                      }

                      if (value < appController.videoModels.length) {
                        appController.indexVideo.value = value;
                      } else {}
                    },
                  ),
                  // currentPage ?? const WidgetProgress(),
                  // currentPage == null ? const WidgetProgress() : currentPage ,
                ],
              ),
            );
    });
  }

  Widget commentButton() {
    return Container(
      width: 200,
      // margin: const EdgeInsets.only(left: 20),
      child: WidgetButton(
        label: 'แสดงความคิดเห็น ...',
        pressFunc: () {
          appController.screenHeights.add(screenHeight! * 0.5 - 50);

          Get.bottomSheet(
            TikTokCommentBottomSheet(
              docIdVideo:
                  appController.docIdVideos[appController.indexVideo.value],
              indexVideo: appController.indexVideo.value,
            ),
          ).then((value) {
            appController.screenHeights.add(screenHeight!);
          });
        },
        // color: ColorPlate.back1.withOpacity(0.5),
        color: GFColors.PRIMARY,
      ),
    );
  }
}
