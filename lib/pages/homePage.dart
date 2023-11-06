// ignore_for_file: avoid_print, prefer_final_fields

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';
import 'package:video_player/video_player.dart';
import 'package:xstream/controller/tikTokVideoListController.dart';
import 'package:xstream/models/user_model.dart';
import 'package:xstream/models/video_model.dart';
import 'package:xstream/pages/add_star.dart';
import 'package:xstream/pages/display_profile_tap_icon.dart';
import 'package:xstream/pages/review_detail_page.dart';
import 'package:xstream/pages/searchPage.dart';
import 'package:xstream/pages/show_map.dart';
import 'package:xstream/pages/userDetailOwnerVideo.dart';
import 'package:xstream/style/physics.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/utility/app_snackbar.dart';
import 'package:xstream/views/bottom_sheet_authen.dart';
import 'package:xstream/views/product_bottomSheet.dart';
import 'package:xstream/views/tikTokCommentBottomSheet.dart';
import 'package:xstream/views/tikTokHeader.dart';
import 'package:xstream/views/tikTokScaffold.dart';
import 'package:xstream/views/tikTokVideo.dart';
import 'package:xstream/views/tikTokVideoButtonColumn.dart';
import 'package:xstream/views/tiktokTabBar.dart';
import 'package:xstream/views/widget_image_network.dart';
import 'package:xstream/views/widget_progress.dart';
import 'package:xstream/views/widget_text.dart';
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

      if (appController.videoModels[0].mapReview!.isNotEmpty) {
        AppService().processReadPlateWhereNameReview(
            collectionPlate: appController.videoModels[0].mapReview!['type'],
            namePlate: appController.videoModels[0].mapReview!['nameReview']);
      }

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

          Get.bottomSheet(
            const BottomSheetAuthen(),
            isScrollControlled: true,
          );
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
          Get.bottomSheet(
            const BottomSheetAuthen(),
            isScrollControlled: true,
          );
        } else {
          //ไปเปิด state เลือกวีดีโอ
          AppService().processUploadVideoFromGallery();
        }
      },
    );

    var searchPage = SearchPage(
      onPop: tkController.animateToMiddle,
    );

    //ส่วนของหัวด้านบน
    var header = tabBarType == TikTokPageTag.home
        ? TikTokHeader(
            onSearch: () {
              tkController.animateToLeft();
            },
            onDiscover: () {
              _videoListController.currentPlayer.pause();
              Get.to(const ShowMap());
            },
            onStar: () {
              _videoListController.currentPlayer.pause();

              Get.to(const ShowMap());

              //เปิด BottomSheet
              //  Get.bottomSheet(const MenuAddBottomSheet());
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
                        onSerway: () {
                          _videoListController.currentPlayer.pause();
                          Get.to(AddStar(
                              videoModel: appController.videoModels[
                                  appController.indexVideo.value]));
                        },
                        onAvatar: () {
                          UserModel userModel = UserModel.fromMap(
                              appController.videoModels[i].mapUserModel);

                          _videoListController.currentPlayer.pause();

                          if (appController.currentUserModels.isEmpty) {
                            Get.bottomSheet(
                              const BottomSheetAuthen(),
                              isScrollControlled: true,
                            );
                          } else {
                            Get.to(UserDetailOwnerVideo(
                              ownerVideoUserModel: userModel,
                            ));
                          }
                        },
                        onDisplayImageProduct: () {
                          _videoListController.currentPlayer.pause();

                          if (appController.currentUserModels.isEmpty) {
                            Get.bottomSheet(
                              const BottomSheetAuthen(),
                              isScrollControlled: true,
                            );
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
                          AppService().processAddLoginToFriend(
                              mapFriendModel:
                                  appController.videoModels[i].mapUserModel);
                        },
                        videoModel: i < appController.videoModels.length
                            ? appController.videoModels[i]
                            : appController.videoModels.last,
                        docIdVideo: appController.docIdVideos[i],
                        indexVideo: i,
                        bottomPadding: 100,
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
                        // commentButton: commentButton(),
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
                          reviewWidget: displayReview(index: i),
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
                      print('##6nov onPageChange value =======> $value');
                      print('##6nov onPageChange indevVideo =======> ${appController.indexVideo}');

                      if (appController
                          .videoModels[value]
                          .mapReview!
                          .isNotEmpty) {
                        AppService().processReadPlateWhereNameReview(
                            collectionPlate: appController
                                .videoModels[value]
                                .mapReview!['type'],
                            namePlate: appController
                                .videoModels[value]
                                .mapReview!['nameReview']);
                      }

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
                ],
              ),
            );
    });
  }

  Widget displayReview({required int index}) {
    return appController.videoModels[index].mapReview!.isEmpty
        ? const SizedBox()
        : Obx(() {
            print(
                '##6nov appController.rateStar ---> ${appController.totalRating}');
            return InkWell(
              onTap: () {
                _videoListController.currentPlayer.pause();

                Get.to(ReviewDetailPage(
                  videoModel: appController.videoModels[index],
                  docIdVideo: appController.docIdVideos[index],
                ))!
                    .then((value) => _videoListController.currentPlayer.play());
              },
              child: Container(
                color: ColorPlate.back1.withOpacity(0.75),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appController.videoModels[index]
                            .mapReview!['urlImageReviews'].isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: WidgetImageNetwork(
                              urlImage: appController.videoModels[index].image,
                              size: 80,
                              boxFit: BoxFit.cover,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: WidgetImageNetwork(
                              boxFit: BoxFit.cover,
                              urlImage: appController.videoModels[index]
                                  .mapReview!['urlImageReviews'].last,
                              size: 80,
                            ),
                          ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 200,
                            child: WidgetText(
                                data: appController.videoModels[index]
                                        .mapReview!['nameReview'] ??
                                    ''),
                          ),

                          SizedBox(
                            width: 230,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 110,
                                      child: RatingBar.builder(
                                        initialRating:
                                            appController.totalRating.value,
                                        itemSize: 20,
                                        itemCount: 5,
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (value) {},
                                      ),
                                    ),
                                    WidgetText(
                                        data: AppService().doubleToString(
                                            number: appController
                                                .totalRating.value)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    WidgetText(
                                        data:
                                            '(${appController.addStartReviewModels.length} รีวิว)'),
                                  ],
                                ),
                                // const Row(
                                //   mainAxisSize: MainAxisSize.min,
                                //   children: [
                                //     Icon(Icons.star_border),
                                //     WidgetText(data: '500'),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          // const SizedBox(height:4,),
                          SizedBox(
                            width: 200,
                            child: WidgetText(
                              data: appController
                                  .videoModels[index].mapReview!['review'],
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
  }
}
