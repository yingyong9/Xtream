// ignore_for_file: public_member_api_docs, sort_constructors_first, sort_child_properties_last
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/models/order_model.dart';

import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/utility/app_snackbar.dart';
import 'package:xstream/views/widget_avatar.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_icon_button.dart';
import 'package:xstream/views/widget_image_network.dart';
import 'package:xstream/views/widget_text.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({
    Key? key,
    required this.indexVideo,
  }) : super(key: key);

  final int indexVideo;

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().findCurrentUserModel();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return Obx(() {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorPlate.back1,
            elevation: 0,
            centerTitle: true,
            title: WidgetText(
              data: 'สรุปคำสั่งซื้อ',
              textStyle: AppConstant().h1Style(context: context),
            ),
          ),
          body: appController.currentUserModels.isEmpty
              ? const SizedBox()
              : ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    displayAddressDelivery(),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      color: ColorPlate.white,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    displayShop(),
                    const SizedBox(
                      height: 16,
                    ),
                    displayProduct(boxConstraints),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.money,
                                size: 36,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              WidgetText(
                                data: 'ชำระเงินปลายทาง',
                                textStyle: AppConstant()
                                    .h1Style(context: context, size: 30),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
          bottomSheet: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: ColorPlate.back1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    WidgetText(
                      data: 'ทั้งหมด',
                      textStyle: AppConstant().h1Style(context: context),
                    ),
                    Obx(() {
                      return WidgetText(
                        data:
                            '฿ ${int.parse(appController.videoModels[widget.indexVideo].priceProduct!) * appController.amount.value}',
                        textStyle: AppConstant().h1Style(context: context),
                      );
                    })
                  ],
                ),
                SizedBox(
                  width: boxConstraints.maxWidth,
                  child: WidgetButton(
                    label: 'ทำการสั่งซื้อ',
                    pressFunc: () async {
                      OrderModel orderModel = OrderModel(
                        amount: appController.amount.value,
                        priceProduct: int.parse(appController
                            .videoModels[widget.indexVideo].priceProduct!),
                        nameProduct: appController
                            .videoModels[widget.indexVideo].nameProduct!,
                        status: 'start',
                        timestamp: Timestamp.fromDate(DateTime.now()),
                        mapAddress: appController
                            .currentUserModels.last.mapAddress!.last,
                        mapBuyer: appController.currentUserModels.last.toMap(),
                        urlImageProduct: appController
                            .videoModels[widget.indexVideo].urlProduct!,
                      );

                      print('orderModel ---> ${orderModel.toMap()}');

                      FirebaseFirestore.instance
                          .collection('user')
                          .doc(appController
                              .videoModels[widget.indexVideo].uidPost)
                          .collection('order')
                          .doc()
                          .set(orderModel.toMap())
                          .then((value) {
                        Get.back();
                        print('########### Order Success #############');
                        AppSnackBar(
                                title: 'สั่งซื้อสำเร็จ',
                                message: 'ขอบคุณที่ สั่งซื้อ')
                            .normalSnackBar();
                      });
                    },
                    color: ColorPlate.red,
                  ),
                )
              ],
            ),
          ),
        );
      });
    });
  }

  Row displayProduct(BoxConstraints boxConstraints) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: ClipRRect(
            child: WidgetImageNetwork(
              urlImage:
                  appController.videoModels[widget.indexVideo].urlProduct!,
              boxFit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          width: boxConstraints.maxWidth - 120 - 32 - 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetText(
                data: appController.videoModels[widget.indexVideo].nameProduct!,
                textStyle: AppConstant().bodyStyle(fontSize: 16),
              ),
              Row(
                children: [
                  WidgetText(
                    data:
                        '฿ ${appController.videoModels[widget.indexVideo].priceProduct!}',
                    textStyle: AppConstant().bodyStyle(fontSize: 14),
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
            ],
          ),
        ),
      ],
    );
  }

  Row displayShop() {
    return Row(
      children: [
        WidgetAvatar(
          urlImage: appController
              .videoModels[widget.indexVideo].mapUserModel['urlAvatar'],
          size: 36,
        ),
        const SizedBox(
          width: 16,
        ),
        WidgetText(
          data:
              appController.videoModels[widget.indexVideo].mapUserModel['name'],
          textStyle: AppConstant().bodyStyle(fontSize: 18),
        ),
      ],
    );
  }

  Column displayAddressDelivery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        displayNamAnPhone(),
        const SizedBox(
          height: 8,
        ),
        WidgetText(
          data:
              '${appController.currentUserModels.last.mapAddress!.last['houseNumber']} ${appController.currentUserModels.last.mapAddress!.last['district']}\n${appController.currentUserModels.last.mapAddress!.last['amphur']} ${appController.currentUserModels.last.mapAddress!.last['province']}\n${appController.currentUserModels.last.mapAddress!.last['zipcode']}',
          textStyle: AppConstant().bodyStyle(fontSize: 18),
        ),
      ],
    );
  }

  Row displayNamAnPhone() {
    return Row(
      children: [
        WidgetText(
          data: appController.currentUserModels.last.mapAddress!.last['name'],
          textStyle: AppConstant().bodyStyle(fontSize: 20),
        ),
        WidgetText(
          data:
              ' (${appController.currentUserModels.last.mapAddress!.last['phone']})',
          textStyle: AppConstant()
              .bodyStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
