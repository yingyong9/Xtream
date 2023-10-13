import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xstream/models/amphure_model.dart';
import 'package:xstream/models/chat_comment_model.dart';
import 'package:xstream/models/comment_model.dart';
import 'package:xstream/models/districe_model.dart';
import 'package:xstream/models/invoid_model.dart';
import 'package:xstream/models/option_model.dart';
import 'package:xstream/models/order_model.dart';
import 'package:xstream/models/province_model.dart';
import 'package:xstream/models/remark_model.dart';
import 'package:xstream/models/user_model.dart';
import 'package:xstream/models/video_model.dart';

class AppController extends GetxController {
  RxList<VideoModel> videoModels = <VideoModel>[].obs;
  RxList<String> docIdVideos = <String>[].obs;
  RxList<VideoModel> postVideoModels = <VideoModel>[].obs;
  RxList<UserModel> currentUserModels = <UserModel>[].obs;
  RxList<UserModel> generalUserModels = <UserModel>[].obs;
  RxList<UserModel> profileTabUserModels = <UserModel>[].obs;
  RxList<File> files = <File>[].obs;
  RxList<String> nameFiles = <String>[].obs;
  RxList<File> liveFiles = <File>[].obs;
  RxList<String> liveNameFiles = <String>[].obs;
  RxList<File> productFiles = <File>[].obs;
  RxList<String> productNameFiles = <String>[].obs;
  RxInt amount = 1.obs;
  RxList<ProvinceModel> provinceModels = <ProvinceModel>[].obs;
  RxList<ProvinceModel?> chooseProvinceModels = <ProvinceModel?>[null].obs;
  RxList<AmphureModel> amphureModels = <AmphureModel>[].obs;
  RxList<AmphureModel?> chooseAmphureModels = <AmphureModel?>[null].obs;
  RxList<DistriceModel> districeModels = <DistriceModel>[].obs;
  RxList<DistriceModel?> chooseDistriceModels = <DistriceModel?>[null].obs;
  RxBool change = false.obs;
  RxInt indexVideo = 0.obs;
  RxList<CommentModel> commentModels = <CommentModel>[].obs;
  RxInt indexForm = 0.obs;
  RxList<OrderModel> orderModels = <OrderModel>[].obs;
  RxList<String> docIdOrders = <String>[].obs;
  RxInt amountStart = 0.obs;
  RxList<InvoidModel> invoidModels = <InvoidModel>[].obs;
  RxList<String> docIdInvoids = <String>[].obs;
  RxList<RemarkModel> remarkModels = <RemarkModel>[].obs;
  RxInt indexListLive = 0.obs;
  RxBool liveBool = false.obs;
  RxList<OptionModel> optionModels = <OptionModel>[].obs;
  RxBool displaySave = false.obs;
  RxList<String> subOptions = <String>[].obs;
  RxList<ChatCommentModel> chatCommentModels = <ChatCommentModel>[].obs;
  RxList<double> screenHeights = <double>[].obs;
  RxBool displayConfirmButtom = false.obs;
  RxMap mapReview = {}.obs;
  RxList<XFile> xFiles = <XFile>[].obs;
  RxList<Widget> imageNetworkWidgets = <Widget>[].obs;

  RxInt indexCategory = 0.obs;

  RxMap<String, dynamic> foodSum = {'โดยรวม': 0.0}.obs;
  RxMap<String, dynamic> foodItem1 = {'รสชาติ': 0.0}.obs;
  RxMap<String, dynamic> foodItem2 = {'สิ่งแวดล้อม': 0.0}.obs;
  RxMap<String, dynamic> foodItem3 = {'บริการ': 0.0}.obs;
  RxMap<String, dynamic> foodItem4 = {'วัตถุดิบ': 0.0}.obs;

  RxList<String?> chooseTypes = <String?>[null].obs;

  RxList<Position> positions = <Position>[].obs;
}
