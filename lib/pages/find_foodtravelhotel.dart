import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/bodys/list_food.dart';
import 'package:xstream/bodys/list_hotel.dart';
import 'package:xstream/bodys/list_travel.dart';
import 'package:xstream/pages/insert_name_plate.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_gf_button.dart';
import 'package:xstream/views/widget_text.dart';

class FindFoodTravelHotel extends StatefulWidget {
  const FindFoodTravelHotel({super.key});

  @override
  State<FindFoodTravelHotel> createState() => _FindFoodTravelHotelState();
}

class _FindFoodTravelHotelState extends State<FindFoodTravelHotel> {
  AppController appController = Get.put(AppController());

  var categorys = <String>[
    'Food',
    'Travel',
    'Hotel',
  ];

  var bodys = <Widget>[
    const ListFood(),
    const ListTravel(),
    const ListHotel(),
  ];

  @override
  void initState() {
    super.initState();
    AppService().processFindPosition().then((value) {
      print('position -----> ${appController.positions.last}');
      AppService().readLandMark();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
          return Obx(() {
            print('indexCat ---> ${appController.indexCategory}');
            return SizedBox(
              width: boxConstraints.maxWidth,
              height: boxConstraints.maxHeight - 50,
              child: Stack(
                children: [
                  const WidgetBackButton(),
                  Positioned(
                    top: 50,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            itemCount: categorys.length,
                            itemBuilder: (context, index) => Column(
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: boxConstraints.maxWidth / 3,
                                  alignment: Alignment.center,
                                  child: InkWell(
                                      onTap: () {
                                        appController.indexCategory.value = index;
                                      },
                                      child: WidgetText(data: categorys[index])),
                                ),
                                Container(
                                  height: 4, width: boxConstraints.maxWidth / 3,
                                  color: appController.indexCategory.value == index
                                      ? Colors.blue
                                      : ColorPlate.back1,
                                  // child: WidgetText(data: '  '),
                                ),
                               
                              ],
                            ),
                            scrollDirection: Axis.horizontal,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                          ),
                          
                        ),
                        bodys[appController.indexCategory.value],
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        }),
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
