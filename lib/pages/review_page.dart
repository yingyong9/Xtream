// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/models/plate_model.dart';
import 'package:xstream/models/review_model.dart';

import 'package:xstream/pages/register_shop.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_form_line.dart';
import 'package:xstream/views/widget_gf_button.dart';
import 'package:xstream/views/widget_ratting.dart';
import 'package:xstream/views/widget_text.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({
    super.key,
    required this.indexReviewCat,
  });

  final int indexReviewCat;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  AppController appController = Get.put(AppController());
  TextEditingController headReviewController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  final formStateKey = GlobalKey<FormState>();

  final debouncer = Debouncer(milliSecond: 500);

  @override
  void initState() {
    super.initState();

    appController.displayListPlate.value = false;

    if (appController.imageNetworkWidgets.isNotEmpty) {
      appController.imageNetworkWidgets.clear();
      appController.xFiles.clear();
      appController.rating.value = 0;
    }
    appController.imageNetworkWidgets.add(inkwellWidget());

    AppService()
        .readPlateModels(
            collrctionPlate:
                AppConstant.collectionPlates[widget.indexReviewCat])
        .then((value) {
      appController.searchPlateModels.addAll(appController.plateModels);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Form(
              key: formStateKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  head(),
                  imageGridView(),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: SizedBox(
                      width: 250,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          appController.displayListPlate.value
                              ? Container(
                                  padding: const EdgeInsets.all(8),
                                  width: 250,
                                  height: 150,
                                  decoration: AppConstant().borderBox(),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount:
                                        appController.searchPlateModels.length,
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {
                                        headReviewController.text =
                                            appController
                                                .searchPlateModels[index].name;

                                        FocusManager.instance.primaryFocus?.unfocus();
                                      },
                                      child: Row(
                                        children: [
                                          WidgetText(
                                              data: appController
                                                  .searchPlateModels[index]
                                                  .name),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          WidgetFormLine(
                            hint: 'ชื่อที่รีวิว',
                            textEditingController: headReviewController,
                            changeFunc: (p0) {
                              if (p0.isNotEmpty) {
                                appController.displayListPlate.value = true;

                                debouncer.run(() {
                                  if (appController
                                      .searchPlateModels.isNotEmpty) {
                                    appController.searchPlateModels.clear();
                                    appController.searchPlateModels
                                        .addAll(appController.plateModels);
                                  }

                                  appController.searchPlateModels.value =
                                      appController.searchPlateModels
                                          .where((element) => element.name
                                              .toLowerCase()
                                              .contains(p0.toLowerCase()))
                                          .toList();
                                });
                              } else {
                                appController.displayListPlate.value = false;
                                appController.searchPlateModels
                                    .addAll(appController.plateModels);
                              }
                            },
                            validateFunc: (p0) {
                              if (p0?.isEmpty ?? true) {
                                return 'โปรดกรอกชื่อสถานที่รีวิว';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      appController.displayListPlate.value = false;
                    },
                    controller: reviewController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration:
                        const InputDecoration(hintText: 'เขียนรีวิว'),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  WidgetRatingStar(
                    title: 'ให้คะแนนสถานที่นี้',
                    sizeIcon: 30,
                    map: appController.foodSum,
                    ratingUpdateFunc: (double rating) {
                      appController.rating.value = rating;
                    },
                  ),
                  const SizedBox(
                    height: 64,
                  )
                ],
              ),
            ),
          ),
        );
      }),
      bottomSheet: Container(
        decoration: const BoxDecoration(color: ColorPlate.back1),
        child: WidgetButton(
          label: 'โพสต์',
          pressFunc: () async {
            
            if (formStateKey.currentState!.validate()) {
              String docIdPlate = await AppService().findDocIdPlate(
                  collection:
                      AppConstant.collectionPlates[widget.indexReviewCat],
                  name: headReviewController.text);

              print('##31oct docIdPlate ----> $docIdPlate');

              if (docIdPlate.isEmpty) {
                //ชื่อร้านใหม่

                PlateModel plateModel =
                    PlateModel(name: headReviewController.text, province: '');

                DocumentReference documentReference = FirebaseFirestore.instance
                    .collection(
                        AppConstant.collectionPlates[widget.indexReviewCat])
                    .doc();

                await documentReference
                    .set(plateModel.toMap())
                    .then((value) async {
                  docIdPlate = documentReference.id;

                  print('##1nov docIdPlate ใหม่ที่ได้ ----> $docIdPlate');

                  var urlImageReviews = <String>[];

                  if (appController.xFiles.isNotEmpty) {
                    urlImageReviews = await AppService()
                        .processUploadMultiFile(path: 'review');
                  }

                  await methodAddNewReview(docIdPlate).then((value) {
                    Map<String, dynamic> map = {};
                    map['nameReview'] = headReviewController.text;
                    map['review'] = reviewController.text;
                    map['type'] =
                        AppConstant.collectionPlates[widget.indexReviewCat];
                    map['rating'] = appController.rating.value;
                    map['urlImageReviews'] = urlImageReviews;

                    //ตรงนี่แหละ ที่ Get Back และ ส่ง map กลับ
                    Get.back(result: map);
                  });
                });
              } else {
                var urlImageReviews = <String>[];

                if (appController.xFiles.isNotEmpty) {
                  urlImageReviews =
                      await AppService().processUploadMultiFile(path: 'review');
                }

                await methodAddNewReview(docIdPlate).then((value) {
                  Map<String, dynamic> map = {};
                  map['nameReview'] = headReviewController.text;
                  map['review'] = reviewController.text;
                  map['type'] =
                      AppConstant.collectionPlates[widget.indexReviewCat];
                  map['rating'] = appController.rating.value;
                  map['urlImageReviews'] = urlImageReviews;

                  //ตรงนี่แหละ ที่ Get Back และ ส่ง map กลับ
                  Get.back(result: map);
                });
              }

             
            }
          },
          fullWidthButton: true,
          color: ColorPlate.red,
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

  Row head() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WidgetBackButton(
          pressFunc: () {
            if (appController.files.isNotEmpty) {
              appController.files.clear();
              appController.nameFiles.clear();
            }
            Get.back();
          },
        ),
        WidgetText(
          data: AppConstant.reviewCats[widget.indexReviewCat],
          textStyle: AppConstant().bodyStyle(fontSize: 20),
        ),
        const SizedBox(),
        // WidgetTextButton(
        //   label: 'บันทึก',
        //   pressFunc: () async {
        //     if (appController.files.isEmpty) {
        //       AppSnackBar(title: 'Image ?', message: 'กรุณาเลือกภาพ')
        //           .errorSnackBar();
        //     } else if (textEditingController.text.isEmpty) {
        //       AppSnackBar(
        //               title: 'ซื่อร้านค้า ?', message: 'กรุณากรอก ซื่อร้านค้า')
        //           .errorSnackBar();
        //     } else {
        //       AppService().processUploadFileImageReview().then((value) {
        //         Map<String, dynamic> map = {};
        //         map['urlImageReview'] = value;
        //         map['nameShop'] = textEditingController.text;

        //         print('map ---> $map');

        //         // appController.mapReview.value = map;
        //         Get.back(result: map);
        //       });
        //     }
        //   },
        // )
      ],
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

  Future<void> methodAddNewReview(String docIdPlate) async {
    var urlImageReviews = <String>[];

    if (appController.xFiles.isNotEmpty) {
      urlImageReviews =
          await AppService().processUploadMultiFile(path: 'review2');
    }

    ReviewModel reviewModel = ReviewModel(
        rating: appController.rating.value,
        review: reviewController.text,
        urlImageReviews: urlImageReviews,
        timestamp: Timestamp.fromDate(DateTime.now()),
        mapUserModel: appController.currentUserModels.last.toMap());

    print('##27oct reviewModel ---> ${reviewModel.toMap()}');

    FirebaseFirestore.instance
        .collection(AppConstant.collectionPlates[widget.indexReviewCat])
        .doc(docIdPlate)
        .collection('review')
        .doc()
        .set(reviewModel.toMap())
        .then((value) {});
  }
}

class Debouncer {
  final int milliSecond;
  Timer? timer;
  VoidCallback? voidCallback;
  Debouncer({
    required this.milliSecond,
    this.timer,
    this.voidCallback,
  });

  run(VoidCallback voidCallback) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: milliSecond), voidCallback);
  }
}
