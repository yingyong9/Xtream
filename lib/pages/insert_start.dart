// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/models/review_model.dart';

import 'package:xstream/models/video_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form_multiline.dart';
import 'package:xstream/views/widget_form_no_line.dart';
import 'package:xstream/views/widget_ratting_only.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';

class InsertStar extends StatefulWidget {
  const InsertStar({
    Key? key,
    required this.videoModel,
  }) : super(key: key);

  final VideoModel videoModel;

  @override
  State<InsertStar> createState() => _InsertStarState();
}

class _InsertStarState extends State<InsertStar> {
  AppController appController = Get.put(AppController());

  var options = <String>[];
  var textEditControllers = <TextEditingController>[];

  @override
  void initState() {
    super.initState();

    if (widget.videoModel.mapReview!['type'] ==
        AppConstant.collectionPlates[0]) {
      //Food
      options.addAll(AppConstant.optionFoods);
      createTextEditController();
    } else if (widget.videoModel.mapReview!['type'] ==
        AppConstant.collectionPlates[1]) {
      //Travel
      options.addAll(AppConstant.optionTravels);
      createTextEditController();
    } else if (widget.videoModel.mapReview!['type'] ==
        AppConstant.collectionPlates[2]) {
      //Hotel
      options.addAll(AppConstant.optionHotels);
      createTextEditController();
    } else {
      options.addAll(AppConstant.optionOthers);
      createTextEditController();
    }

    if (appController.rateStar.value != 0.0) {
      appController.rateStar.value = 0.0;
    }

    if (appController.imageNetworkWidgets.isNotEmpty) {
      appController.imageNetworkWidgets.clear();
    }

    if (appController.xFiles.isNotEmpty) {
      appController.xFiles.clear();
    }

    appController.imageNetworkWidgets.add(inkwellWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const WidgetBackButton(),
        title:
            WidgetText(data: 'ติดดาว ${widget.videoModel.mapReview!['type']}'),
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        actions: [
          Obx(() {
            return WidgetTextButton(
              label: 'ส่ง',
              textStyle: AppConstant().bodyStyle(
                  fontSize: 22,
                  color: appController.rateStar.value == 0.0
                      ? Colors.white30
                      : ColorPlate.red),
              pressFunc: () {
                if (appController.rateStar.value != 0.0) {
                  processSentInsertStart();
                }
              },
            );
          })
        ],
      ),
      body: Obx(() {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetRatingStarOnly(
                    initialRating: appController.rateStar.value,
                    ratingUpdateFunc: (p0) {
                      appController.rateStar.value = p0;
                    },
                    sizeIcon: 48,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              imageGridView(),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: 32,
                      child: WidgetText(data: options[index]),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      height: 32,
                      child: const WidgetText(data: ' : '),
                    ),
                    Expanded(
                        child: (index == (options.length - 1))
                            ? WidgetFormMultiLine(
                                textEditingController:
                                    textEditControllers[index],
                              )
                            : WidgetFormNoLine(
                                textEditingController:
                                    textEditControllers[index],
                              )),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  InkWell inkwellWidget() {
    return InkWell(
      onTap: () {
        AppService().takeMultiPhoto();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
        ),
        width: 120,
        height: 120,
        child: const Icon(
          Icons.add_a_photo_outlined,
          size: 36,
        ),
      ),
    );
  }

  GridView imageGridView() {
    return GridView.count(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      children: appController.imageNetworkWidgets,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
    );
  }

  Future<void> processSentInsertStart() async {
    var urlImageReviews = <String>[];

    if (appController.xFiles.isNotEmpty) {
      urlImageReviews =
          await AppService().processUploadMultiFile(path: 'review');
    }

    var chooseOptions = <String>[];
    var chooseValue = <String>[];

    for (var i = 0; i < options.length; i++) {
      if (textEditControllers[i].text.isNotEmpty) {
        chooseOptions.add(options[i]);
        chooseValue.add(textEditControllers[i].text);
      }
    }

    ReviewModel reviewModel = ReviewModel(
      rating: appController.rateStar.value,
      review: '',
      urlImageReviews: urlImageReviews,
      timestamp: Timestamp.fromDate(DateTime.now()),
      mapUserModel: appController.currentUserModels.last.toMap(),
      options: chooseOptions,
      valueOptions: chooseValue,
    );

    // print('##1nov You Click Sent reviewModel ----> ${reviewModel.toMap()}');
    print(
        '##1nov You Click Sent reviewModel at chooseOption ----> ${reviewModel.options}');
    print(
        '##1nov You Click Sent reviewModel at chooseValue ----> ${reviewModel.valueOptions}');

    AppService()
        .processInsertReview(
            collectionName: widget.videoModel.mapReview!['type'],
            name: widget.videoModel.mapReview!['nameReview'],
            map: reviewModel.toMap())
        .then((value) {
      print('##2nov Success insert Review');
      Get.back();
    });
  }

  void createTextEditController() {
    for (var element in options) {
      textEditControllers.add(TextEditingController());
    }
  }
}
