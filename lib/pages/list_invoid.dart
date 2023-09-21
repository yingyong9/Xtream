import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xstream/pages/big_image.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_dialog.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/utility/app_snackbar.dart';
import 'package:xstream/views/widget_avatar.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_icon_button.dart';
import 'package:xstream/views/widget_image_file.dart';
import 'package:xstream/views/widget_image_network.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';

class ListInvoid extends StatefulWidget {
  const ListInvoid({super.key});

  @override
  State<ListInvoid> createState() => _ListInvoidState();
}

class _ListInvoidState extends State<ListInvoid> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: appController.invoidModels.isEmpty
          ? Center(
              child: WidgetText(
              data: 'ไม่มี คำสั่งซื่อ',
              textStyle: AppConstant().h1Style(context: context),
            ))
          : ListView.builder(
              itemCount: appController.invoidModels.length,
              itemBuilder: (context, index) => ExpansionTile(
                trailing: Obx(() {
                  return appController.invoidModels.isEmpty
                      ? const SizedBox()
                      : Icon(
                          Icons.shopping_cart,
                          color: appController.invoidModels[index].status ==
                                  'start'
                              ? Colors.red
                              : appController.invoidModels[index].status ==
                                      'order'
                                  ? Colors.purple
                                  : Colors.green,
                        );
                }),
                title: Column(
                  children: [
                    Obx(() {
                      return appController.invoidModels.isEmpty
                          ? const SizedBox()
                          : Row(
                              children: [
                                WidgetImageNetwork(
                                  urlImage: appController
                                      .invoidModels[index].urlImageProduct,
                                  size: 50,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                SizedBox(
                                  // width: 145,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          WidgetText(
                                              data: appController
                                                  .invoidModels[index]
                                                  .refNumber),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          WidgetText(
                                            data: AppService().timeToString(
                                                timestamp: appController
                                                    .invoidModels[index]
                                                    .timestamp),
                                            textStyle: AppConstant()
                                                .bodyStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 230,
                                        child: WidgetText(
                                          data: appController
                                              .invoidModels[index].nameProduct,
                                          textStyle: AppConstant().bodyStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      WidgetText(
                                          data:
                                              'จำนวน ${appController.invoidModels[index].amount.toString()}'),
                                    ],
                                  ),
                                ),
                              ],
                            );
                    }),
                  ],
                ),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetText(
                          data: appController
                              .currentUserModels.last.mapAddress!.last['name']),
                      WidgetText(
                        data:
                            '${appController.currentUserModels.last.mapAddress!.last['houseNumber']} ${appController.currentUserModels.last.mapAddress!.last['district']} ${appController.currentUserModels.last.mapAddress!.last['amphur']}\n${appController.currentUserModels.last.mapAddress!.last['province']} ${appController.currentUserModels.last.mapAddress!.last['zipcode']}',
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: WidgetImageNetwork(
                              urlImage: appController
                                  .invoidModels[index].urlImageProduct,
                              size: 80,
                              boxFit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250,
                                child: WidgetText(
                                  maxLines: 2,
                                  data: appController
                                      .invoidModels[index].nameProduct,
                                  textStyle: AppConstant().bodyStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                              Row(
                                children: [
                                  WidgetText(
                                      data:
                                          'ราคา ${appController.invoidModels[index].priceProduct}'),
                                  const WidgetText(data: ' X '),
                                  WidgetText(
                                      data:
                                          'จำนวน ${appController.invoidModels[index].amount}'),
                                ],
                              ),
                              WidgetText(
                                data:
                                    'รวมเงิน ${appController.invoidModels[index].priceProduct * appController.invoidModels[index].amount} THB',
                                textStyle: AppConstant().bodyStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          WidgetButton(
                            label: 'รับออเตอร์',
                            pressFunc: () {},
                            color: Colors.purple,
                          ),
                          Obx(() {
                            return appController.invoidModels.isEmpty
                                ? const SizedBox()
                                : appController.invoidModels[index].status ==
                                        'start'
                                    ? const SizedBox()
                                    : appController.invoidModels[index]
                                                .timestampOrder ==
                                            Timestamp(0, 0)
                                        ? const SizedBox()
                                        : WidgetText(
                                            data: AppService().timeToString(
                                                timestamp: appController
                                                    .invoidModels[index]
                                                    .timestampOrder!));
                          }),
                        ],
                      ),
                      Obx(() {
                        return appController.invoidModels.isEmpty
                            ? const SizedBox()
                            : appController.invoidModels[index].status ==
                                    'delivery'
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      deliveryButton(index),
                                      WidgetText(
                                          data: AppService().timeToString(
                                              timestamp: appController
                                                  .invoidModels[index]
                                                  .timestampDelivery!)),
                                    ],
                                  )
                                : const SizedBox();
                      }),
                    ],
                  )
                ],
              ),
            ),
    );
  }

  AppBar mainAppBar() {
    return AppBar(
      backgroundColor: ColorPlate.back1,
      elevation: 0,
      title: const WidgetText(data: 'คำสั่งซื้อของฉัน'),
    );
  }

  WidgetButton deliveryButton(int index) {
    return WidgetButton(
      label: 'ส่งสินค้า',
      pressFunc: () {
        Get.to(
            BigImage(urlImage: appController.invoidModels[index].urlDelivery!));
      },
      color: Colors.green,
    );
  }

  void dialogTakePhoto({required int indexMap}) {
    if (appController.files.isNotEmpty) {
      appController.files.clear();
    }

    AppDialog().normalDialog(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorPlate.gray,
                borderRadius: BorderRadius.circular(10)),
            width: 180,
            height: 180,
            child: Obx(() {
              return appController.files.isEmpty
                  ? Row(
                      children: [
                        WidgetIconButton(
                          iconData: Icons.camera_alt,
                          pressFunc: () {
                            AppService().processTakePhoto(
                                imageSource: ImageSource.camera);
                          },
                        ),
                        const WidgetText(data: 'ถ่ายรูปใบส่งสินค้า'),
                      ],
                    )
                  : WidgetImageFile(
                      fileImage: appController.files.last,
                      size: 180,
                    );
            }),
          ),
        ],
      ),
      firstAction: WidgetTextButton(
        label: 'Upload',
        pressFunc: () async {
          String? urlDelivery = await AppService().processUploadDelivery(
              fileDelivery: appController.files.last,
              nameFile:
                  '${appController.invoidModels[indexMap].refNumber}.jpg');

          Map<String, dynamic> map =
              appController.invoidModels[indexMap].toMap();

          String docIdOrder = appController.docIdOrders[indexMap];

          map['urlDelivery'] = urlDelivery;
          map['status'] = 'delivery';
          map['timestampDelivery'] = Timestamp.fromDate(DateTime.now());

          FirebaseFirestore.instance
              .collection('user')
              .doc(appController.currentUserModels.last.uid)
              .collection('order')
              .doc(docIdOrder)
              .update(map)
              .then((value) {
            AppService().readAllOrder();
          });

          Get.back();
        },
      ),
      secondAction: WidgetTextButton(
        label: 'Cancel',
        pressFunc: () {
          Get.back();
        },
      ),
    );
  }

  Future<void> processTakeAction(
      {required int index, required String status}) async {
    print('docIdorder ----> ${appController.docIdOrders[index]}');

    Map<String, dynamic> map = appController.invoidModels[index].toMap();
    map['status'] = status;

    switch (status) {
      case 'order':
        map['timestampOrder'] = Timestamp.fromDate(DateTime.now());
        break;
      case 'delivery':
        map['timestampDelivery'] = Timestamp.fromDate(DateTime.now());
        break;
      default:
    }

    print('timeOrder -----> ${map['timestampOrder']}');
    print('timeDelivery -----> ${map['timestampDelivery']}');

    FirebaseFirestore.instance
        .collection('user')
        .doc(appController.currentUserModels.last.uid)
        .collection('order')
        .doc(appController.docIdOrders[index])
        .update(map)
        .then((value) {
      AppService().readAllOrder();
    });
  }
}
