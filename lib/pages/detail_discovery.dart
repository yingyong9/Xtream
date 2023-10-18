import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_form_line.dart';
import 'package:xstream/views/widget_text.dart';

class DetailDiscovery extends StatefulWidget {
  const DetailDiscovery({super.key});

  @override
  State<DetailDiscovery> createState() => _DetailDiscoveryState();
}

class _DetailDiscoveryState extends State<DetailDiscovery> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    if (appController.imageNetworkWidgets.isNotEmpty) {
      appController.imageNetworkWidgets.clear();
      appController.xFiles.clear();
      appController.rating.value = 0;
    }
    appController.imageNetworkWidgets.add(inkwellWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          children: [
            WidgetForm(
              labelWidget: WidgetText(data: 'ชื่อสิ่งที่จะสำรวจ'),
            ),
            GridView.count(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              children: appController.imageNetworkWidgets,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
             WidgetForm(
              labelWidget: WidgetText(data: 'คำอธิบาย'),
            ),
          ],
        ),
      ),
    );
  }

  InkWell inkwellWidget() {
    return InkWell(
      onTap: () {
        AppService().takeMultiPhoto();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
        ),
        width: 120,
        height: 120,
        child: const Icon(
          Icons.add_a_photo_outlined,
          size: 36,
        ),
      ),
    );
  }
}
