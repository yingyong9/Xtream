import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_avatar.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_image_network.dart';
import 'package:xstream/views/widget_text.dart';

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
      ),
      body: appController.orderModels.isEmpty
          ? Center(
              child: WidgetText(
              data: 'ไม่มี Order',
              textStyle: AppConstant().h1Style(context: context),
            ))
          : ListView.builder(
              // padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: appController.orderModels.length,
              itemBuilder: (context, index) => ExpansionTile(
                trailing: const Icon(
                  Icons.shopping_cart,
                  color: Colors.red,
                ),
                title: Column(
                  children: [
                    Row(
                      children: [
                        // WidgetImageNetwork(urlImage: appController.orderModels[index].urlImageProduct, size: 48, boxFit: BoxFit.cover,),
                        WidgetAvatar(
                          urlImage: appController
                              .orderModels[index].mapBuyer['urlAvatar'],
                          size: 48,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          // width: 145,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  WidgetText(
                                    data: appController
                                        .orderModels[index].mapBuyer['name'],
                                    textStyle: AppConstant().bodyStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 32,
                                  ),
                                  WidgetText(
                                    data: AppService().timeToString(
                                        timestamp: appController
                                            .orderModels[index].timestamp),
                                    textStyle:
                                        AppConstant().bodyStyle(fontSize: 16),
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
                                      color: Colors.grey.shade600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const Spacer(),
                      ],
                    ),
                    // const Divider(
                    //   color: Colors.white,
                    // ),
                  ],
                ),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetText(
                          data: 'OrderNumber : Ref${Random().nextInt(100000)}'),
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
                            pressFunc: () {},
                            color: Colors.purple,
                          ),
                          WidgetButton(
                            label: 'ส่งสินค้า',
                            pressFunc: () {},
                            color: Colors.green,
                          ),
                          WidgetButton(
                            label: 'พิมพ์บิล',
                            pressFunc: () {},
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
