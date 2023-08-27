// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/pages/add_address_delivery.dart';
import 'package:xstream/pages/order_page.dart';

import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_icon_button.dart';
import 'package:xstream/views/widget_image_network.dart';
import 'package:xstream/views/widget_text.dart';

class ProductButtonSheet extends StatelessWidget {
  const ProductButtonSheet({
    Key? key,
    required this.indexVideo,
  }) : super(key: key);

  final int indexVideo;

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          return Container(
            height: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: ColorPlate.back1,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetText(
                      data: 'สั่งซื้อสินค้า',
                      textStyle: AppConstant().bodyStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorPlate.red),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                levelOne(appController, context),
                const Divider(),
                Row(
                  children: [
                    const WidgetText(
                      data: 'จำนวน',
                      textStyle: TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    WidgetIconButton(
                      iconData: Icons.remove,
                      color: Colors.white,
                      pressFunc: () {
                        if (appController.amount.value > 1) {
                          appController.amount.value--;
                        }
                      },
                    ),
                    WidgetText(
                      data: appController.amount.toString(),
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    WidgetIconButton(
                      iconData: Icons.add,
                      color: Colors.white,
                      pressFunc: () {
                        appController.amount.value++;
                      },
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: WidgetButton(
                    label: 'ยืนยัน',
                    pressFunc: () {
                      print(
                          'mapAddress ----> ${appController.currentUserModels.last.mapAddress!.length}');

                      Get.back();

                      if (appController
                          .currentUserModels.last.mapAddress!.isEmpty) {
                        Get.to(AddAddressDelivery(
                          videoModel: appController.videoModels[indexVideo],
                          amountProduct: appController.amount.value,
                          indexVideo: indexVideo,
                        ));
                      } else {
                        Get.to(OrderPage(
                          indexVideo: indexVideo,
                        ));
                      }
                    },
                    color: ColorPlate.red,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Row levelOne(AppController appController, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetImageNetwork(
          urlImage: appController.videoModels[indexVideo].urlProduct!,
          size: 120,
          boxFit: BoxFit.cover,
        ),
        const SizedBox(
          width: 16,
        ),
        WidgetText(
          data: '฿ ${appController.videoModels[indexVideo].priceProduct}',
          textStyle: AppConstant().h1Style(context: context),
        ),
        const Spacer(),
        const WidgetBackButton()
      ],
    );
  }
}
