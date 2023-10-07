// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:ftpconnect/ftpconnect.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:restart_app/restart_app.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:path/path.dart';
import 'package:xstream/models/amphure_model.dart';
import 'package:xstream/models/chat_comment_model.dart';
import 'package:xstream/models/comment_model.dart';
import 'package:xstream/models/districe_model.dart';
import 'package:xstream/models/invoid_model.dart';
import 'package:xstream/models/order_model.dart';
import 'package:xstream/models/otp_require_thaibulk.dart';
import 'package:xstream/models/province_model.dart';
import 'package:xstream/models/remark_model.dart';
import 'package:xstream/models/user_model.dart';
import 'package:xstream/models/video_model.dart';
import 'package:xstream/pages/check_video.dart';
import 'package:xstream/pages/homePage.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_snackbar.dart';

class AppService {
  AppController appController = Get.put(AppController());

  String timeToString({required Timestamp timestamp}) {
    DateFormat dateFormat = DateFormat('dd/MM HH:mm');
    return dateFormat.format(timestamp.toDate());
  }

  Future<void> processTakePhoto({required ImageSource imageSource}) async {
    var result = await ImagePicker()
        .pickImage(source: imageSource, maxWidth: 800, maxHeight: 800);
    if (result != null) {
      File file = File(result.path);
      appController.files.add(file);
      String nameFile = basename(file.path);
      appController.nameFiles.add(nameFile);
    }
  }

  Future<void> processTakePhotoLive({required ImageSource imageSource}) async {
    var result = await ImagePicker()
        .pickImage(source: imageSource, maxWidth: 800, maxHeight: 800);
    if (result != null) {
      File file = File(result.path);
      appController.liveFiles.add(file);
      String nameFile = basename(file.path);
      appController.liveNameFiles.add(nameFile);
    }
  }

  Future<void> processFtpUploadAndInsertDataVideo({
    required File fileVideo,
    required String nameFileVideo,
    required String urlThumbnail,
    required String detail,
    String? nameProduct,
    String? priceProduct,
    String? stockProduct,
    String? affiliateProduct,
    String? urlProduct,
    String? phoneContact,
    String? linkLine,
    String? linkMessaging,
    String? urlImagelive,
    String? liveTitle,
    Timestamp? startLive,
  }) async {
    //  Get.offAll(HomePage());

    FTPConnect ftpConnect = FTPConnect(AppConstant.host,
        user: AppConstant.user, pass: AppConstant.pass);
    await ftpConnect.connect();
    bool response = await ftpConnect.uploadFileWithRetry(fileVideo,
        pRemoteName: nameFileVideo);
    await ftpConnect.disconnect();

    if (response) {
      VideoModel videoModel = VideoModel(
        url:
            'https://stream115.otaro.co.th:443/vod/mp4:$nameFileVideo/playlist.m3u8',
        image: urlThumbnail,
        desc: nameFileVideo,
        detail: detail,
        timestamp: Timestamp.fromDate(
          DateTime.now(),
        ),
        mapUserModel: appController.currentUserModels.last.toMap(),
        nameProduct: nameProduct ?? '',
        priceProduct: priceProduct ?? '',
        stockProduct: stockProduct ?? '',
        affiliateProduct: affiliateProduct ?? '',
        urlProduct: urlProduct ?? '',
        uidPost: appController.currentUserModels.last.uid,
        urlImageLive: urlImagelive ?? '',
        startLive: startLive ?? Timestamp(0, 0),
        liveTitle: liveTitle ?? '',
      );

      FirebaseFirestore.instance
          .collection('video')
          .doc()
          .set(videoModel.toMap())
          .then((value) {
        //Sent Noti All User
        processSentAllNoti(title: 'วีดีโอใหม่', body: detail);

        if (appController.files.isNotEmpty) {
          appController.files.clear();
        }

        if (appController.liveFiles.isNotEmpty) {
          appController.liveFiles.clear();
        }

        Get.offAll(const HomePage());
        AppSnackBar(title: 'Upload Video Success', message: 'Thankyou')
            .normalSnackBar();
      });
    }
  }

  Future<String?> processUploadThumbnailVideo(
      {required File fileThumbnail, required String nameFile}) async {
    String? urlThumbnail;

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference = firebaseStorage.ref().child('thumbnail/$nameFile');
    UploadTask uploadTask = reference.putFile(fileThumbnail);
    await uploadTask.whenComplete(() async {
      urlThumbnail = await reference.getDownloadURL();
    });

    return urlThumbnail;
  }

  Future<String?> processUploadDelivery(
      {required File fileDelivery, required String nameFile}) async {
    String? urlDelivery;

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference = firebaseStorage.ref().child('delivery/$nameFile');
    UploadTask uploadTask = reference.putFile(fileDelivery);
    await uploadTask.whenComplete(() async {
      urlDelivery = await reference.getDownloadURL();
    });

    return urlDelivery;
  }

  Future<String?> processUploadFile({required String path}) async {
    String? urlImage;

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference =
        firebaseStorage.ref().child('$path/${appController.nameFiles.last}');
    UploadTask uploadTask = reference.putFile(appController.files.last);
    await uploadTask.whenComplete(() async {
      urlImage = await reference.getDownloadURL();
    });

    return urlImage;
  }

  Future<String?> processUploadFileImageLive({required String path}) async {
    String? urlImage;

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference = firebaseStorage
        .ref()
        .child('$path/${appController.liveNameFiles.last}');
    UploadTask uploadTask = reference.putFile(appController.liveFiles.last);
    await uploadTask.whenComplete(() async {
      urlImage = await reference.getDownloadURL();
    });

    return urlImage;
  }

  Future<void> verifyOTPThaibulk(
      {required String token,
      required String pin,
      required BuildContext context,
      required String phoneNumber}) async {
    try {
      String urlApi = 'https://otp.thaibulksms.com/v2/otp/verify';
      Map<String, dynamic> map = {};
      map['key'] = AppConstant.key;
      map['secret'] = AppConstant.secret;
      map['token'] = token;
      map['pin'] = pin;

      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';
      await dio.post(urlApi, data: map).then((value) async {
        print('##7oct statusCode --> ${value.statusCode}');
        if (value.statusCode == 200) {
          //Everything OK

          AppSnackBar(title: 'OTP True', message: 'Welcome').normalSnackBar();

          await FirebaseFirestore.instance
              .collection('user')
              .where('phone', isEqualTo: phoneNumber)
              .get()
              .then((value) async {
            if (value.docs.isEmpty) {
              //ยังไม่สมัครสมาชิค

              await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: 'email$phoneNumber@xstream.com',
                      password: '123456')
                  .then((value) async {
                String uid = value.user!.uid;
                UserModel userModel = UserModel(
                  name: 'Khun$phoneNumber',
                  uid: uid,
                  urlAvatar: AppConstant.urlAvatar,
                  phone: phoneNumber,
                  friends: [],
                );
                await FirebaseFirestore.instance
                    .collection('user')
                    .doc(uid)
                    .set(userModel.toMap())
                    .then((value) {
                  if (GetPlatform.isAndroid) {
                    Restart.restartApp();
                  } else {
                    AppService()
                        .findCurrentUserModel()
                        .then((value) => Get.offAll(const HomePage()));
                  }
                });
              }).catchError((onError) {});
            } else {
              //เป็นสมาชิกแล้ว
              print('เป็นสมาชิกแล้ว');

              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: 'email$phoneNumber@xstream.com',
                      password: '123456')
                  .then((value) {
                if (GetPlatform.isAndroid) {
                  Restart.restartApp();
                } else {
                  AppService()
                      .findCurrentUserModel()
                      .then((value) => Get.offAll(const HomePage()));
                }
              });
            }
          });
        }
      });
    } on Exception catch (e) {
      print(e);
      // Get.back();
      AppSnackBar(title: 'OTP ผิด', message: 'กรุณาลองใหม่').errorSnackBar();
    }
  }

  Future<OtpRequireThaibulk> processSentSmsThaibulk(
      {required String phoneNumber}) async {
    String urlApi = 'https://otp.thaibulksms.com/v2/otp/request';

    Map<String, dynamic> map = {};
    map['key'] = AppConstant.key;
    map['secret'] = AppConstant.secret;
    map['msisdn'] = phoneNumber;

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/x-www-form-urlencoded';

    var result = await dio.post(urlApi, data: map);
    OtpRequireThaibulk otpRequireThaibulk =
        OtpRequireThaibulk.fromMap(result.data);
    return otpRequireThaibulk;
  }

  Future<void> readAllVideo() async {
    await FirebaseFirestore.instance
        .collection('video')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) async {
      if (appController.videoModels.isNotEmpty) {
        appController.videoModels.clear();
        appController.docIdVideos.clear();
      }
      for (var element in value.docs) {
        VideoModel videoModel = VideoModel.fromMap(element.data());
        appController.videoModels.add(videoModel);
        appController.docIdVideos.add(element.id);
      }
    });
  }

  Future<void> findCurrentUserModel() async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(user.uid)
          .get()
          .then((value) {
        if (value.data() != null) {
          UserModel userModel = UserModel.fromMap(value.data()!);

          appController.currentUserModels.add(userModel);
        }
      });
    }
  }

  Future<void> processSignOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      if (GetPlatform.isAndroid) {
        Restart.restartApp();
      } else {
         appController.currentUserModels.clear();
      Get.offAll(const HomePage());
      AppSnackBar(title: 'Sign Out Success', message: 'Sign Out Success')
          .normalSnackBar();
      }

     
    });
  }

  Future<void> processUploadVideoFromGallery() async {
    try {
      var result = await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (result != null) {
        File file = File(result.path);

        int i = Random().nextInt(1000000);
        String nameFileVideo = 'xtream$i.mp4';
        String nameFileImage = 'xtream$i.jpg';

        final pathThumbnailFile =
            await VideoThumbnail.thumbnailFile(video: file.path);

        File thumbnailFile = File(pathThumbnailFile.toString());

        Get.offAll(CheckVideo(
            fileThumbnail: thumbnailFile,
            fileVideo: file,
            nameFileVideo: nameFileVideo,
            nameFileImage: nameFileImage));

        //ส่วนของเดิม ที่ไม่มีการ Check Video
        // Get.offAll(DetailPost(
        //     fileThumbnail: thumbnailFile,
        //     fileVideo: file,
        //     nameFileVideo: nameFileVideo,
        //     nameFileImage: nameFileImage));
      }
    } on Exception catch (e) {
      print(e.toString());
      AppSnackBar(
              title: 'เปลี่ยนวีดีโอ',
              message: 'ขออภัยด้วยไม่สามารถใช้ วีดีโอนี่ได้')
          .errorSnackBar();
    }
  }

  Future<void> readAllProvince() async {
    if (appController.provinceModels.isNotEmpty) {
      appController.provinceModels.clear();
      appController.chooseProvinceModels.clear();
      appController.chooseProvinceModels.add(null);

      appController.amphureModels.clear();
      appController.chooseAmphureModels.clear();
      appController.chooseAmphureModels.add(null);

      appController.districeModels.clear();
      appController.chooseDistriceModels.clear();
      appController.chooseDistriceModels.add(null);
    }

    String urlApi = 'https://www.androidthai.in.th/flutter/getAllprovinces.php';

    await Dio().get(urlApi).then((value) {
      for (var element in json.decode(value.data)) {
        ProvinceModel provinceModel = ProvinceModel.fromMap(element);
        appController.provinceModels.add(provinceModel);
      }
    });
  }

  Future<void> readAmphure({required String provinceId}) async {
    if (appController.amphureModels.isNotEmpty) {
      appController.amphureModels.clear();
      appController.chooseAmphureModels.clear();
      appController.chooseAmphureModels.add(null);
    }

    String urlApi =
        'https://www.androidthai.in.th/flutter/getAmpByProvince.php?isAdd=true&province_id=$provinceId';
    await Dio().get(urlApi).then((value) {
      for (var element in json.decode(value.data)) {
        AmphureModel amphureModel = AmphureModel.fromMap(element);
        appController.amphureModels.add(amphureModel);
      }
    });
  }

  Future<void> readDistrice({required String amphureId}) async {
    if (appController.districeModels.isNotEmpty) {
      appController.districeModels.clear();
      appController.chooseDistriceModels.clear();
      appController.chooseDistriceModels.add(null);
    }

    String urlApi =
        'https://www.androidthai.in.th/flutter/getDistriceByAmphure.php?isAdd=true&amphure_id=$amphureId';
    await Dio().get(urlApi).then((value) {
      for (var element in json.decode(value.data)) {
        DistriceModel districeModel = DistriceModel.fromMap(element);
        appController.districeModels.add(districeModel);
      }
    });
  }

  Future<void> processEditProfile({required Map<String, dynamic> map}) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.currentUserModels.last.uid)
        .update(map)
        .then((value) {
      findCurrentUserModel();
      Get.back();
      AppSnackBar(
              title: 'แก้ไขโปรไฟล์ สำเร็จ',
              message: 'แก้ไขโปรไฟล์ สำเร็จ ขอบคุณครับ')
          .normalSnackBar();
    });
  }

  Future<void> findUrlImageVideo({required String uid}) async {
    FirebaseFirestore.instance.collection('video').get().then((value) {
      if (appController.postVideoModels.isNotEmpty) {
        appController.postVideoModels.clear();
      }

      for (var element in value.docs) {
        VideoModel videoModel = VideoModel.fromMap(element.data());
        if (uid == videoModel.uidPost) {
          appController.postVideoModels.add(videoModel);
        }
      }
    });
  }

  Future<void> insertComment(
      {required String docIdVideo,
      required Map<String, dynamic> mapComment}) async {
    FirebaseFirestore.instance
        .collection('video')
        .doc(docIdVideo)
        .collection('comment')
        .doc()
        .set(mapComment);
  }

  Future<void> readCommentModelByDocIdVideo(
      {required String docIdVideo}) async {
    if (appController.commentModels.isNotEmpty) {
      appController.commentModels.clear();
    }

    FirebaseFirestore.instance
        .collection('video')
        .doc(docIdVideo)
        .collection('comment')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          CommentModel commentModel = CommentModel.fromMap(element.data());
          appController.commentModels.add(commentModel);
        }
      }
    });
  }

  Future<void> processAddLoginToFriend(
      {required Map<String, dynamic> mapFriendModel}) async {
    var result = await FirebaseFirestore.instance
        .collection('user')
        .doc(mapFriendModel['uid'])
        .get();

    UserModel userModel = UserModel.fromMap(result.data()!);
    Map<String, dynamic> map = userModel.toMap();

    print('map ก่อน ---> $map');

    var friends = <String>[];
    friends.addAll(map['friends']);

    if (friends.contains(appController.currentUserModels.last.uid)) {
      //Friend Allreday
      AppSnackBar(
              title: 'เป็น Friend ไปแล้ว',
              message: 'ขออภัย ข้อมูลวีดีโอไม่อัพเดท')
          .errorSnackBar();
    } else {
      friends.add(appController.currentUserModels.last.uid);
      map['friends'] = friends;

      print('map หลัง ---> $map');

      FirebaseFirestore.instance
          .collection('user')
          .doc(mapFriendModel['uid'])
          .update(map)
          .then((value) async {
        print('Update success');
        AppSnackBar(
                title: 'Add Friend สำเร็จ',
                message: 'ขอบคุณ ที่ Add Friend อาจมีข้อมูลวีดีโอไม่อัพเดท')
            .normalSnackBar();
      });
    }
  }

  bool checkStatusFriend({required VideoModel videoModel}) {
    bool result = false; // UnFriend

    UserModel userModel = UserModel.fromMap(videoModel.mapUserModel);

    if (userModel.friends!.isNotEmpty) {
      result =
          userModel.friends!.contains(appController.currentUserModels.last.uid);
    }
    return result;
  }

  Future<void> processIncrease({required String docIdVideo}) async {
    await FirebaseFirestore.instance
        .collection('video')
        .doc(docIdVideo)
        .get()
        .then((value) async {
      VideoModel videoModel = VideoModel.fromMap(value.data()!);
      Map<String, dynamic> map = videoModel.toMap();
      int up = videoModel.up!;
      up++;
      map['up'] = up;

      await FirebaseFirestore.instance
          .collection('video')
          .doc(docIdVideo)
          .update(map)
          .then((value) {
        print('Increase up Success');
      });
    });
  }

  Future<void> processDecrease({required String docIdVideo}) async {
    await FirebaseFirestore.instance
        .collection('video')
        .doc(docIdVideo)
        .get()
        .then((value) async {
      VideoModel videoModel = VideoModel.fromMap(value.data()!);
      Map<String, dynamic> map = videoModel.toMap();
      int down = videoModel.down!;
      down++;
      map['down'] = down;

      await FirebaseFirestore.instance
          .collection('video')
          .doc(docIdVideo)
          .update(map)
          .then((value) {
        print('Decrease up Success');
      });
    });
  }

  Future<void> readAllInvoid() async {
    if (appController.invoidModels.isNotEmpty) {
      appController.invoidModels.clear();
    }

    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.currentUserModels.last.uid)
        .collection('invoid')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          InvoidModel invoidModel = InvoidModel.fromMap(element.data());
          appController.invoidModels.add(invoidModel);
          appController.docIdInvoids.add(element.id);
        }
      }
    });
  }

  Future<void> readAllOrder() async {
    if (appController.orderModels.isNotEmpty) {
      appController.orderModels.clear();
      appController.docIdOrders.clear();
      appController.amountStart.value = 0;
    }

    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.currentUserModels.last.uid)
        .collection('order')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          OrderModel orderModel = OrderModel.fromMap(element.data());
          appController.orderModels.add(orderModel);
          appController.docIdOrders.add(element.id);
          if (orderModel.status == 'start') {
            appController.amountStart.value =
                appController.amountStart.value + 1;
          }
        }
      }
    });
  }

  Future<UserModel> findUserModel({required String uid}) async {
    var result =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();

    UserModel userModel = UserModel.fromMap(result.data()!);
    return userModel;
  }

  Future<void> readAllRemark() async {
    FirebaseFirestore.instance.collection('remark').get().then((value) {
      if (appController.remarkModels.isNotEmpty) {
        appController.remarkModels.clear();
      }

      for (var element in value.docs) {
        RemarkModel remarkModel = RemarkModel.fromMap(element.data());
        appController.remarkModels.add(remarkModel);
      }
    });
  }

  Future<void> readGeneralUserModel() async {
    FirebaseFirestore.instance.collection('user').get().then((value) {
      if (appController.generalUserModels.isNotEmpty) {
        appController.generalUserModels.clear();
      }

      for (var element in value.docs) {
        UserModel userModel = UserModel.fromMap(element.data());
        appController.generalUserModels.add(userModel);
      }
    });
  }

  bool checkTimeLive({required Timestamp startLive}) {
    DateTime startLiveDateTime = startLive.toDate();
    // startLiveDateTime = startLiveDateTime.add(const Duration(hours: 2));
    startLiveDateTime = startLiveDateTime.add(Duration(hours: 1));

    bool result = startLiveDateTime.isAfter(DateTime.now());
    print('###### result ----> $result');

    return result;
  }

  Future<void> processLaunchPrismLive() async {
    await LaunchApp.openApp(
      androidPackageName: 'com.prism.live',
      iosUrlScheme: '',
      appStoreLink: 'https://apps.apple.com/app/id1319056339',
    );
  }

  Future<void> aboutNoti() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();

    print('token ---> $token');

    Map<String, dynamic> map = appController.currentUserModels.last.toMap();
    print('map ------> $map');

    map['token'] = token;
    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.currentUserModels.last.uid)
        .update(map);

    FirebaseMessaging.onMessage.listen((event) {
      displayNoti(
          title: event.notification!.title!, body: event.notification!.body!);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      displayNoti(
          title: event.notification!.title!, body: event.notification!.body!);
    });
  }

  void displayNoti({required String title, required String body}) {
    AppSnackBar(title: title, message: body).normalSnackBar();
  }

  Future<void> processSentAllNoti(
      {required String title, required String body}) async {
    FirebaseFirestore.instance.collection('user').get().then((value) async {
      for (var element in value.docs) {
        UserModel userModel = UserModel.fromMap(element.data());
        if ((userModel.uid != appController.currentUserModels.last.uid) &&
            (userModel.token!.isNotEmpty)) {
          String urlApi =
              'https://www.androidthai.in.th/fluttertraining/noti/weHappyNoti.php?isAdd=true&token=${userModel.token}&title=$title&body=$body';
          await Dio().get(urlApi);
        }
      }
    });
  }

  Future<void> listenChatComment({required String docIdVideo}) async {
    print('##29sep docIdVideo ที่ listenChatComment ---> $docIdVideo');
    FirebaseFirestore.instance
        .collection('video')
        .doc(docIdVideo)
        .collection('comment')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        if (appController.chatCommentModels.isNotEmpty) {
          appController.chatCommentModels.clear();
        }

        for (var element in event.docs) {
          ChatCommentModel chatCommentModel =
              ChatCommentModel.fromMap(element.data());
          appController.chatCommentModels.add(chatCommentModel);
        }
      }
    });
  }
}
