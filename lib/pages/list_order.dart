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
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_icon_button.dart';
import 'package:xstream/views/widget_image_file.dart';
import 'package:xstream/views/widget_image_network.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';

class ListOrder extends StatefulWidget {
  const ListOrder({super.key});

  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        title: WidgetForm(
          prefixWidget: Icon(Icons.search),
          suffixWidget: Icon(Icons.qr_code_2),
        ),
        actions: [
          WidgetIconButton(
            iconData: Icons.add,
            pressFunc: () {},
          )
        ],
        // actions: [
        //   WidgetButton(
        //     label: 'อัพเดทการส่งสินค้า',
        //     pressFunc: () {
        //       TextEditingController textEditingController =
        //           TextEditingController();

        //       bool nonMap = true;

        //       int index = 0;
        //       int indexMap = 0;

        //       AppDialog().normalDialog(
        //         content: WidgetForm(
        //           textEditingController: textEditingController,
        //           labelWidget: const WidgetText(data: 'กรอก refNo.'),
        //         ),
        //         firstAction: WidgetTextButton(
        //           label: 'ยืนยัน',
        //           pressFunc: () {
        //             if (textEditingController.text.isNotEmpty) {
        //               for (var element in appController.orderModels) {
        //                 if (textEditingController.text == element.refNumber) {
        //                   nonMap = false;
        //                   indexMap = index;
        //                 }
        //                 index++;
        //               }

        //               if (nonMap) {
        //                 Get.back();
        //                 AppSnackBar(
        //                         title: 'refNo ไม่ถูกต้อง',
        //                         message: 'กรุณากรอกใหม่')
        //                     .errorSnackBar();
        //               } else {
        //                 Get.back();
        //                 dialogTakePhoto(indexMap: indexMap);
        //               }
        //             } else {
        //               Get.back();
        //             }
        //           },
        //         ),
        //         secondAction: WidgetTextButton(
        //           label: 'ยกเลิก',
        //           pressFunc: () {
        //             Get.back();
        //           },
        //         ),
        //       );
        //     },
        //     color: Colors.green,
        //   ),
        // ],
      ),
      body: appController.orderModels.isEmpty
          ? Center(
              child: WidgetText(
              data: 'ไม่มี Order',
              textStyle: AppConstant().h1Style(context: context),
            ))
          : ListView.builder(
              itemCount: appController.orderModels.length,
              itemBuilder: (context, index) => ExpansionTile(
                trailing: Obx(() {
                  return appController.orderModels.isEmpty
                      ? const SizedBox()
                      : Icon(
                          Icons.shopping_cart,
                          color:
                              appController.orderModels[index].status == 'start'
                                  ? Colors.red
                                  : appController.orderModels[index].status ==
                                          'order'
                                      ? Colors.purple
                                      : Colors.green,
                        );
                }),
                title: Column(
                  children: [
                    Obx(() {
                      return appController.orderModels.isEmpty
                          ? const SizedBox()
                          : Row(
                              children: [
                                WidgetImageNetwork(
                                  urlImage: appController
                                      .orderModels[index].urlImageProduct,
                                  size: 48,
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
                                                  .orderModels[index]
                                                  .refNumber),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          WidgetText(
                                            data: AppService().timeToString(
                                                timestamp: appController
                                                    .orderModels[index]
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
                                              .orderModels[index].nameProduct,
                                          textStyle: AppConstant().bodyStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      WidgetText(
                                          data:
                                              'จำนวน ${appController.orderModels[index].amount.toString()}'),
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
                                  .orderModels[index].urlImageProduct,
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
                                      .orderModels[index].nameProduct,
                                  textStyle: AppConstant().bodyStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                              ),
                              Row(
                                children: [
                                  WidgetText(
                                      data:
                                          'ราคา ${appController.orderModels[index].priceProduct}'),
                                  const WidgetText(data: ' X '),
                                  WidgetText(
                                      data:
                                          'จำนวน ${appController.orderModels[index].amount}'),
                                ],
                              ),
                              WidgetText(
                                data:
                                    'รวมเงิน ${appController.orderModels[index].priceProduct * appController.orderModels[index].amount} THB',
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
                            pressFunc: () {
                              if (appController.orderModels[index].status ==
                                  'start') {
                                processTakeAction(
                                    index: index, status: 'order');
                              } else if (appController
                                      .orderModels[index].status ==
                                  'order') {
                                AppSnackBar(
                                        title: 'สินค้า Order',
                                        message: 'โปรดเตรียมการจัดส่ง')
                                    .errorSnackBar();
                              } else {
                                AppSnackBar(
                                        title: 'สินค้าได้จัดส่งแล้ว',
                                        message: 'ขอบคุณ')
                                    .normalSnackBar();
                              }
                            },
                            color: Colors.purple,
                          ),
                          Obx(() {
                            return appController.orderModels.isEmpty
                                ? const SizedBox()
                                : appController.orderModels[index].status ==
                                        'start'
                                    ? const SizedBox()
                                    : appController.orderModels[index]
                                                .timestampOrder ==
                                            Timestamp(0, 0)
                                        ? const SizedBox()
                                        : WidgetText(
                                            data: AppService().timeToString(
                                                timestamp: appController
                                                    .orderModels[index]
                                                    .timestampOrder!));
                          }),
                        ],
                      ),
                      Obx(() {
                        return appController.orderModels.isEmpty
                            ? const SizedBox()
                            : appController.orderModels[index].status ==
                                    'delivery'
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      deliveryButton(index),
                                      WidgetText(
                                          data: AppService().timeToString(
                                              timestamp: appController
                                                  .orderModels[index]
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

  WidgetButton deliveryButton(int index) {
    return WidgetButton(
      label: 'ส่งสินค้า',
      pressFunc: () {
        Get.to(
            BigImage(urlImage: appController.orderModels[index].urlDelivery!));
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
              nameFile: '${appController.orderModels[indexMap].refNumber}.jpg');

          Map<String, dynamic> map =
              appController.orderModels[indexMap].toMap();

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

    Map<String, dynamic> map = appController.orderModels[index].toMap();
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
