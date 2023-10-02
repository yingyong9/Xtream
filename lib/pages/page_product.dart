import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
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

  @override
  void initState() {
    super.initState();
    AppService().readAllOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return appController.orderModels.isEmpty
          ? const SizedBox()
          : StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: appController.orderModels
                  .map((element) =>
                      WidgetImageNetwork(urlImage: element.urlImageProduct))
                  .toList(),
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
