import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/pages/create_tiker.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_gf_button.dart';
import 'package:xstream/views/widget_text.dart';

class RegisterShop extends StatefulWidget {
  const RegisterShop({super.key});

  @override
  State<RegisterShop> createState() => _RegisterShopState();
}

class _RegisterShopState extends State<RegisterShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const Row(
              children: [
                WidgetBackButton(),
              ],
            ),
            const WidgetForm(
              labelWidget: WidgetText(data: 'ชื่อร้านค้า หรือ ที่พัก'),
            ),
            const SizedBox(
              height: 16,
            ),
            const WidgetForm(
              labelWidget: WidgetText(data: 'จังหวัด หรือ สาขา'),
            ),
            CheckboxListTile(
              value: false,
              onChanged: (value) {},
              title: WidgetText(
                data: 'ระบุตำแหน่ง',
                textStyle: AppConstant().bodyStyle(fontSize: 15),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Row(
              children: [
                inkwellWidget(),
              ],
            ),
            WidgetGfButton(
              label: 'สร้าง Tiker',
              pressFunc: () {
                Get.to(const CreateTiker());
              },
            ),
            WidgetGfButton(
              label: 'สร้างรายการสินค้า',
              pressFunc: () {},
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
