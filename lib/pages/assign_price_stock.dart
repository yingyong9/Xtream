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

  final formStateKey = GlobalKey<FormState>();

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
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return SafeArea(
          child: Form(
            key: formStateKey,
            child: SizedBox(
              width: boxConstraints.maxWidth,
              height: boxConstraints.maxHeight - 60,
              child: ListView.builder(
                itemCount: appController.optionModels[0].subOptions.length,
                itemBuilder: (context, index1) => ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: appController.optionModels[1].subOptions.length,
                  itemBuilder: (context, index2) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: const BoxDecoration(color: ColorPlate.darkGray),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GFTypography(
                            text:
                                '${appController.optionModels[0].subOptions[index1]} - ${appController.optionModels[1].subOptions[index2]}',
                            showDivider: false,
                            textColor: Colors.white,
                          ),
                        ),
                        WidgetFormUnderLine(
                          prefixWidget: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              WidgetText(data: 'ราคาขายปลีก (฿)'),
                            ],
                          ),
                          hint: 'ใสราคา',
                          validateFunc: (p0) {
                            if (p0?.isEmpty ?? true) {
                              return 'ใสราคา';
                            } else {
                              return null;
                            }
                          },
                          saveFunc: (p0) {},
                        ),
                        WidgetFormUnderLine(
                         prefixWidget: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              WidgetText(data: 'จำนวน'),
                            ],
                          ),
                          hint: 'ใสจำนวน',
                          validateFunc: (p0) {
                            if (p0?.isEmpty ?? true) {
                              return 'ใส่จำนวน';
                            } else {
                              return null;
                            }
                          },
                          saveFunc: (p0) {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
      bottomSheet: GFButton(
        onPressed: () {
          if (formStateKey.currentState!.validate()) {
            formStateKey.currentState!.save();
          }
        },
        text: 'ส่ง',
        fullWidthButton: true,
      ),
    );
  }
}
