// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:xstream/models/video_model.dart';
import 'package:xstream/pages/insert_start.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_avatar.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_gf_button.dart';
import 'package:xstream/views/widget_image_network.dart';
import 'package:xstream/views/widget_ratting_only.dart';
import 'package:xstream/views/widget_text.dart';

class AddStar extends StatefulWidget {
  const AddStar({
    super.key,
    required this.videoModel,
  });

  final VideoModel videoModel;

  @override
  State<AddStar> createState() => _AddStarState();
}

class _AddStarState extends State<AddStar> {
  AppController appController = Get.put(AppController());

  int? indexReviewCat;

  @override
  void initState() {
    super.initState();

    // appController.totalRating.value = 0.0;

    int i = 0;

    for (var element in AppConstant.collectionPlates) {
      if (element == widget.videoModel.mapReview!['type']) {}
      i++;
    }

    readReview();
  }

  void readReview() {
    AppService()
        .processReadPlateWhereNameReview(
            collectionPlate: widget.videoModel.mapReview!['type'],
            namePlate: widget.videoModel.mapReview!['nameReview'])
        .then((value) async {
      appController.totalRating.value = await calculateRating();
    });
  }

  Future<double> calculateRating() async {
    double resultRating = 0.0;
    double result = 0.0;
    for (var element in appController.addStartReviewModels) {
      resultRating = resultRating + element.rating.toDouble();
    }
    if (appController.addStartReviewModels.isNotEmpty) {
      result =
          resultRating / appController.addStartReviewModels.length.toDouble();
    }
   
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        leading: const WidgetBackButton(),
        title: WidgetText(data: widget.videoModel.mapReview!['nameReview']),
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return Obx(() {
          print(
              '##2nov totalRating at body ----> ${appController.totalRating} ');
          return SizedBox(
            width: boxConstraints.maxWidth,
            height: boxConstraints.maxHeight,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      WidgetRatingStarOnly(
                        initialRating: appController.totalRating.value,
                        ratingUpdateFunc: (p0) {},
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      WidgetText(
                        data: AppService().doubleToString(
                            number: appController.totalRating.value),
                        textStyle: AppConstant()
                            .bodyStyle(color: ColorPlate.red, fontSize: 14),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      WidgetText(
                          data:
                              '(${appController.addStartReviewModels.length} รีวิว)'),
                    ],
                  ),
                ),
                Positioned(
                  top: 50,
                  child: appController.addStartReviewModels.isEmpty
                      ? const SizedBox()
                      : SizedBox(
                          width: boxConstraints.maxWidth,
                          height: boxConstraints.maxHeight - 80,
                          child: ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                appController.addStartReviewModels.length,
                            itemBuilder: (context, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    WidgetAvatar(
                                      urlImage: appController
                                          .addStartReviewModels[index]
                                          .mapUserModel['urlAvatar'],
                                      size: 25,
                                    ),
                                    WidgetText(
                                        data: appController
                                            .addStartReviewModels[index]
                                            .mapUserModel['name']),
                                  ],
                                ),
                                WidgetRatingStarOnly(
                                  initialRating: appController
                                      .addStartReviewModels[index].rating,
                                  ratingUpdateFunc: (p0) {},
                                ),
                                WidgetText(
                                    data: appController
                                        .addStartReviewModels[index].review),
                                appController.addStartReviewModels[index]
                                        .urlImageReviews.isEmpty
                                    ? const SizedBox()
                                    : SizedBox(
                                        height: 120,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: appController
                                              .addStartReviewModels[index]
                                              .urlImageReviews
                                              .length,
                                          itemBuilder: (context, index2) =>
                                              Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: WidgetImageNetwork(
                                              urlImage: appController
                                                  .addStartReviewModels[index]
                                                  .urlImageReviews[index2],
                                              size: 120,
                                              boxFit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                const SizedBox(
                                  height: 16,
                                ),
                                appController.addStartReviewModels[index]
                                        .options!.isEmpty
                                    ? const SizedBox()
                                    : ListView.builder(
                                        physics: const ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: appController
                                            .addStartReviewModels[index]
                                            .options!
                                            .length,
                                        itemBuilder: (context, index2) => Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            WidgetText(
                                                data:
                                                    '${appController.addStartReviewModels[index].options![index2]} :'),
                                            WidgetText(
                                                data: appController
                                                    .addStartReviewModels[index]
                                                    .valueOptions![index2]),
                                          ],
                                        ),
                                      ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Divider(
                                  color: Colors.white,
                                ),
                                // const SizedBox(
                                //   height: 32,
                                // )
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        });
      }),
      bottomSheet: WidgetGfButton(
        label: 'ติดดาว',
        pressFunc: () {
          Get.to(InsertStar(
            videoModel: widget.videoModel,
          ))!
              .then((value) {
            readReview();
          });
        },
        fullScreen: true,
        color: ColorPlate.red,
      ),
    );
  }
}
