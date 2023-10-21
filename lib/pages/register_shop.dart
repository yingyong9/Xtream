// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/models/plate_model.dart';

import 'package:xstream/pages/create_tiker.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_gf_button.dart';
import 'package:xstream/views/widget_text.dart';

class RegisterShop extends StatefulWidget {
  const RegisterShop({
    Key? key,
    required this.collectionPlate,
  }) : super(key: key);

  final String collectionPlate;

  @override
  State<RegisterShop> createState() => _RegisterShopState();
}

class _RegisterShopState extends State<RegisterShop> {
  final formKey = GlobalKey<FormState>();

  TextEditingController textEditingController = TextEditingController();
  TextEditingController provinceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const WidgetBackButton(),
                  WidgetText(data: widget.collectionPlate),
                ],
              ),
              WidgetForm(
                textEditingController: textEditingController,
                labelWidget: const WidgetText(data: 'ชื่อร้านค้า หรือ ที่พัก'),
                validatorFunc: (p0) {
                  if (p0?.isEmpty ?? true) {
                    return 'กรุณากรอกชือร้านค้า';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
               WidgetForm(textEditingController: provinceController,
                labelWidget: WidgetText(data: 'จังหวัด หรือ สาขา'),
              ),
              // CheckboxListTile(
              //   value: false,
              //   onChanged: (value) {},
              //   title: WidgetText(
              //     data: 'ระบุตำแหน่ง',
              //     textStyle: AppConstant().bodyStyle(fontSize: 15),
              //   ),
              //   controlAffinity: ListTileControlAffinity.leading,
              // ),
              // Row(
              //   children: [
              //     inkwellWidget(),
              //   ],
              // ),
              // WidgetGfButton(
              //   label: 'สร้าง Tiker',
              //   pressFunc: () {
              //     Get.to(const CreateTiker());
              //   },
              // ),
              // WidgetGfButton(
              //   label: 'สร้างรายการสินค้า',
              //   pressFunc: () {},
              // ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: const BoxDecoration(color: ColorPlate.back1),
        child: WidgetGfButton(
          label: 'บันทึก',
          pressFunc: () {
            if (formKey.currentState!.validate()) {
              PlateModel plateModel =
                  PlateModel(name: textEditingController.text, province: provinceController.text);
              AppService()
                  .processInsertPlate(
                      plateModel: plateModel,
                      collectionPlate: widget.collectionPlate)
                  .then((value) => Get.back());
            }
          },
          fullScreen: true,
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
