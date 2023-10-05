import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:xstream/pages/authen.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_image.dart';
import 'package:xstream/views/widget_text.dart';

class BottomSheetAuthen extends StatelessWidget {
  const BottomSheetAuthen({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16),
            child: const WidgetBackButton(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const WidgetImage(
                    path: 'images/tuktuk.png',
                    size: 150,
                  ),
                  WidgetText(
                    data: 'TikTik',
                    textStyle: AppConstant()
                        .bodyStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: WidgetButton(
              iconWidget: const Icon(Icons.phone_android),
              label: 'เข้าสู่ระบบด้วยหมายเลขโทรศัพย์',
              pressFunc: () {
                Get.back();
                Get.to(const Authen());
              },
              color: ColorPlate.red,
              gfButtonShape: GFButtonShape.pills,
              fullWidthButton: true,
            ),
          )
        ],
      ),
    );
  }
}
