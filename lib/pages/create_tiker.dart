import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_gf_button.dart';
import 'package:xstream/views/widget_ratting.dart';
import 'package:xstream/views/widget_ratting_only.dart';
import 'package:xstream/views/widget_text.dart';

class CreateTiker extends StatefulWidget {
  const CreateTiker({super.key});

  @override
  State<CreateTiker> createState() => _CreateTikerState();
}

class _CreateTikerState extends State<CreateTiker> {
  TextEditingController textEditingController = TextEditingController();

  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: ListView(padding: const EdgeInsets.only(bottom: 60),
              children: [
                const Row(
                  children: [
                    WidgetBackButton(),
                  ],
                ),
                WidgetRatingStar(
                  title: 'โดยรวม',
                  ratingUpdateFunc: (p0) {},
                ),
                appController.ratingStarWidgets.isEmpty
                    ? const SizedBox()
                    : ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appController.ratingStarWidgets.length,
                        itemBuilder: (context, index) =>
                            appController.ratingStarWidgets[index],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: WidgetForm(
                        textEditingController: textEditingController,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetRatingStarOnly(
                      ratingUpdateFunc: (p0) {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WidgetGfButton(
                      label: 'เพิ่ม Tiker',
                      pressFunc: () {
                        if (textEditingController.text.isNotEmpty) {
                          appController.ratingStarWidgets.add(WidgetRatingStar(
                            title: textEditingController.text,
                            ratingUpdateFunc: (p0) {},
                          ));
                          textEditingController.clear();
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
      bottomSheet: Container(decoration: BoxDecoration(color: ColorPlate.back1),
        child: WidgetGfButton(
          label: 'บันทึก',
          pressFunc: () {},fullScreen: true,
        ),
      ),
    );
  }
}
