import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xstream/pages/detail_discovery.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/menu_add_bottom_sheet.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_text.dart';

class ShowMap extends StatefulWidget {
  const ShowMap({super.key});

  @override
  State<ShowMap> createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();

    AppService().processFindPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return Obx(() {
          return SafeArea(
              child: appController.positions.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      width: boxConstraints.maxWidth,
                      height: boxConstraints.maxHeight,
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  appController.positions.last.latitude,
                                  appController.positions.last.longitude),
                              zoom: 16,
                            ),
                            myLocationEnabled: true,
                          ),
                          const WidgetBackButton(color: Colors.black,),
                        ],
                      ),
                    ));
        });
      }),
      bottomSheet: Container(
        decoration: BoxDecoration(color: Colors.grey.shade200),
        child: WidgetButton(
          fullWidthButton: true,
          label: 'ไปสำรวจกัน',
          pressFunc: () {
            // Get.to(const DetailDiscovery());
            Get.bottomSheet(const MenuAddBottomSheet());
          },
        ),
      ),
    );
  }
}
