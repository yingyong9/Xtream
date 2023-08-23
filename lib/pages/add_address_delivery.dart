// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xstream/models/address_model.dart';
import 'package:xstream/models/video_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/utility/app_snackbar.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_text.dart';

class AddAddressDelivery extends StatefulWidget {
  const AddAddressDelivery({
    Key? key,
    required this.videoModel,
    required this.amountProduct,
  }) : super(key: key);

  final VideoModel videoModel;
  final int amountProduct;

  @override
  State<AddAddressDelivery> createState() => _AddAddressDeliveryState();
}

class _AddAddressDeliveryState extends State<AddAddressDelivery> {
  AppController appController = Get.put(AppController());

  TextEditingController nameReceiveController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppService().readAllProvince();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        title: const WidgetText(data: 'ที่อยู่จัดส่ง'),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            nameForm(),
            phoneFome(),
            provinceDropDown(),
            amphurDropdown(),
            districeDropdown(),
            homeNumberForm(),
            moreDetailForm(),
            saveButton(),
          ],
        ),
      ),
    );
  }

  Obx districeDropdown() {
    return Obx(() {
      return appController.districeModels.isEmpty
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ColorPlate.darkGray,
                      borderRadius: BorderRadius.circular(10)),
                  width: 250,
                  height: 50,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton<dynamic>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: appController.districeModels
                        .map(
                          (element) => DropdownMenuItem(
                            child: Row(
                              children: [
                                WidgetText(data: element.name_th),
                                const SizedBox(
                                  width: 16,
                                ),
                                WidgetText(data: element.zip_code),
                              ],
                            ),
                            value: element,
                          ),
                        )
                        .toList(),
                    value: appController.chooseDistriceModels.last,
                    hint: WidgetText(data: 'โปรดเลือกตำบล'),
                    onChanged: (value) {
                      appController.chooseDistriceModels.add(value);
                    },
                  ),
                ),
              ],
            );
    });
  }

  Obx amphurDropdown() {
    return Obx(() {
      return appController.amphureModels.isEmpty
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ColorPlate.darkGray,
                      borderRadius: BorderRadius.circular(10)),
                  width: 250,
                  height: 50,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton<dynamic>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: appController.amphureModels
                        .map(
                          (element) => DropdownMenuItem(
                            child: WidgetText(data: element.name_th),
                            value: element,
                          ),
                        )
                        .toList(),
                    value: appController.chooseAmphureModels.last,
                    hint: WidgetText(data: 'โปรดเลือกอำเภอ'),
                    onChanged: (value) {
                      appController.chooseAmphureModels.add(value);
                      AppService().readDistrice(amphureId: value.id);
                    },
                  ),
                ),
              ],
            );
    });
  }

  Obx provinceDropDown() {
    return Obx(() {
      return appController.provinceModels.isEmpty
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ColorPlate.darkGray,
                      borderRadius: BorderRadius.circular(10)),
                  width: 250,
                  height: 50,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton<dynamic>(
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: appController.provinceModels
                        .map(
                          (element) => DropdownMenuItem(
                            child: WidgetText(data: element.name_th),
                            value: element,
                          ),
                        )
                        .toList(),
                    value: appController.chooseProvinceModels.last,
                    hint: WidgetText(data: 'โปรดเลือกจังหวัด'),
                    onChanged: (value) {
                      appController.chooseAmphureModels.clear();
                      appController.chooseAmphureModels.add(null);

                      appController.districeModels.clear();
                      appController.chooseDistriceModels.clear();
                      appController.chooseDistriceModels.add(null);

                      appController.chooseProvinceModels.add(value);
                      AppService().readAmphure(provinceId: value.id);
                    },
                  ),
                ),
              ],
            );
    });
  }

  Row phoneFome() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          margin: const EdgeInsets.only(top: 8),
          child: WidgetForm(
            textEditingController: phoneNumberController,
            labelWidget: const WidgetText(data: 'เบอร์โทรศัพย์มือถือ ***'),
          ),
        ),
      ],
    );
  }

  Row nameForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          margin: const EdgeInsets.only(top: 8),
          child: WidgetForm(
            textEditingController: nameReceiveController,
            labelWidget: const WidgetText(data: 'ชื่อ-นามผู้รับ ***'),
          ),
        ),
      ],
    );
  }

  Widget homeNumberForm() {
    return Obx(() {
      return appController.chooseDistriceModels.last == null
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(top: 8),
                  child: WidgetForm(
                    textEditingController: homeNumberController,
                    labelWidget: const WidgetText(data: 'บ้านเลขที่ ***'),
                  ),
                ),
              ],
            );
    });
  }

  Widget moreDetailForm() {
    return Obx(() {
      return appController.chooseDistriceModels.last == null
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  margin: const EdgeInsets.only(top: 8),
                  child: WidgetForm(
                    textEditingController: remarkController,
                    labelWidget: const WidgetText(
                        data: 'ข้อมูลเพิ่มเติมให้ขนส่ง(อาจมี)'),
                  ),
                ),
              ],
            );
    });
  }

  Widget saveButton() {
    return Obx(() {
      return appController.chooseDistriceModels.last == null
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  margin: EdgeInsets.only(top: 8),
                  child: WidgetButton(
                    label: 'บันทึก',
                    pressFunc: () {
                      if ((nameReceiveController.text.isEmpty) ||
                          (phoneNumberController.text.isEmpty) ||
                          (homeNumberController.text.isEmpty)) {
                        AppSnackBar(
                                title: 'กรอกข้อมูลไม่ครบ',
                                message: 'ข้อมูลที่มี *** ต้องกรอกให้ครบ')
                            .errorSnackBar();
                      } else {
                        print('OK');

                        AddressModel addressModel = AddressModel(
                            name: nameReceiveController.text,
                            phone: phoneNumberController.text,
                            province: appController.provinceModels.last.name_th,
                            amphur: appController.amphureModels.last.name_th,
                            district: appController.districeModels.last.name_th,
                            houseNumber: homeNumberController.text,
                            remark: remarkController.text);
                      }
                    },
                    color: ColorPlate.red,
                  ),
                ),
              ],
            );
    });
  }
}
