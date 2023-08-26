import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_avatar.dart';
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
          ? const SizedBox()
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: appController.orderModels.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Row(
                    children: [
                      WidgetAvatar(
                        urlImage: appController
                            .orderModels[index].mapBuyer['urlAvatar'],
                        size: 36,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        width: 250,
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
                            WidgetText(
                              data:
                                  appController.orderModels[index].nameProduct,
                              textStyle: AppConstant().bodyStyle(
                                  fontSize: 16, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.red,
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
    );
  }
}
