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

    int i = 0;

    for (var element in AppConstant.collectionPlates) {
      if (element == widget.videoModel.mapReview!['type']) {}
      i++;
    }

    AppService().processReadPlateWhereNameReview(
        collectionPlate: widget.videoModel.mapReview!['type'],
        namePlate: widget.videoModel.mapReview!['nameReview']);
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
          return SizedBox(
            width: boxConstraints.maxWidth,
            height: boxConstraints.maxHeight,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetRatingStarOnly(
                      ratingUpdateFunc: (p0) {},
                    ),
                    const WidgetText(data: 'จาก 100 คน'),
                  ],
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
          Get.to(InsertStar(videoModel: widget.videoModel,));
        },
        fullScreen: true,
        color: ColorPlate.red,
      ),
    );
  }
}
