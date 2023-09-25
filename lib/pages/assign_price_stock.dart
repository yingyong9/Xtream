import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form_underline.dart';
import 'package:xstream/views/widget_text.dart';

class AssignPriceStock extends StatefulWidget {
  const AssignPriceStock({super.key});

  @override
  State<AssignPriceStock> createState() => _AssignPriceStockState();
}

class _AssignPriceStockState extends State<AssignPriceStock> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const WidgetBackButton(),
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        title: const WidgetText(data: 'กำหนดราคา และ สต๊อก'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, BoxConstraints boxConstraints) {
          return SafeArea(
            child: SizedBox(width: boxConstraints.maxWidth,height: boxConstraints.maxHeight-60,
              child: ListView.builder(
                itemCount: appController.optionModels[0].subOptions.length,
                itemBuilder: (context, index1) => ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: appController.optionModels[1].subOptions.length,
                  itemBuilder: (context, index2) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: ColorPlate.darkGray),
                    child: Column(
                      children: [
                        GFTypography(
                          text:
                              '${appController.optionModels[0].subOptions[index1]} - ${appController.optionModels[1].subOptions[index2]}',
                          showDivider: false,
                          textColor: Colors.white,
                        ),
                        WidgetFormUnderLine(
                          hint: 'ราคาขายปลีก (฿) จำเป็น',
                        ),
                        WidgetFormUnderLine(
                          hint: 'จำนวน',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
      bottomSheet: GFButton(
        onPressed: () {},text: 'ส่ง',fullWidthButton: true,
      ),
    );
  }
}
