import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_playter_video.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_web_view.dart';

class ListLive extends StatefulWidget {
  const ListLive({super.key});

  @override
  State<ListLive> createState() => _ListLiveState();
}

class _ListLiveState extends State<ListLive> {
  PageController? pageController;

  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().readGeneralUserModel();

    pageController =
        PageController(initialPage: appController.indexListLive.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return appController.generalUserModels.isEmpty
              ? const SizedBox()
              : WidgetText(
                  data: appController
                      .generalUserModels[appController.indexListLive.value]
                      .name);
        }),
      ),
      body: Obx(() {
        return SafeArea(
          child: PageView(
            scrollDirection: Axis.vertical,
            controller: pageController,
            children: appController.generalUserModels
                .map(
                  (element) => WidgetWebView(
                    streamKey: element.uid.substring(0, 6),
                  ),
                )
                .toList(),
            onPageChanged: (value) {
              appController.indexListLive.value = value;
            },
          ),
        );
      }),
    );
  }
}
