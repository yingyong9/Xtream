import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:xstream/pages/add_new_product.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_image_network.dart';
import 'package:xstream/views/widget_text.dart';

class PageProduct extends StatefulWidget {
  const PageProduct({super.key});

  @override
  State<PageProduct> createState() => _PageProductState();
}

class _PageProductState extends State<PageProduct> {
  AppController appController = Get.put(AppController());

  var widgets = <Widget>[];

  @override
  void initState() {
    super.initState();
    AppService().readAllOrder().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return appController.orderModels.isEmpty
          ? const SizedBox()
          : MasonryGridView.count(
              itemCount: appController.orderModels.length,
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
             
        itemBuilder: (context, index) => Card(
          color: Colors.white,
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetImageNetwork(
                    urlImage:
                        appController.orderModels[index].urlImageProduct),
                const SizedBox(
                  height: 16,
                ),
                WidgetText(
                  data: appController.orderModels[index].nameProduct,
                  textStyle: AppConstant()
                      .bodyStyle(color: Colors.black, fontSize: 18),
                ),
                WidgetText(
                  data:
                      '฿ ${appController.orderModels[index].priceProduct}',
                  textStyle: AppConstant().bodyStyle(
                      color: ColorPlate.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                WidgetText(
                  data: 'คงเหลือ } ',
                  textStyle: AppConstant().bodyStyle(color: Colors.black),
                ),
                WidgetText(
                  data: 'ขายแล้ว ',
                  textStyle: AppConstant().bodyStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      );

      // : GridView.builder(
      //     itemCount: appController.orderModels.length,
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 3,
      //         childAspectRatio: 4 / 5,
      //         mainAxisSpacing: 4,
      //         crossAxisSpacing: 4),
      //     itemBuilder: (context, index) => WidgetImageNetwork(
      //       urlImage: appController.orderModels[index].urlImageProduct,
      //       boxFit: BoxFit.cover,
      //     ),
      //   );
    });
  }
}
