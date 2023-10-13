import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/pages/insert_name_plate.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_gf_button.dart';

class FindFoodTravelHotel extends StatefulWidget {
  const FindFoodTravelHotel({super.key});

  @override
  State<FindFoodTravelHotel> createState() => _FindFoodTravelHotelState();
}

class _FindFoodTravelHotelState extends State<FindFoodTravelHotel> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().processFindPosition().then((value) {
      print('position -----> ${appController.positions.last}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: WidgetBackButton(),
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(color: ColorPlate.back1),
        child: WidgetGfButton(
          label: '+ เพิ่ม Food / Travel / Hotel',
          pressFunc: () {
            Get.to(const InsertNamePlate());
          },
          fullScreen: true,
          color: ColorPlate.red,
        ),
      ),
    );
  }
}
