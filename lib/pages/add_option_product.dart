import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:xstream/pages/add_option_product_form.dart';
import 'package:xstream/pages/add_sub_option_form.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_snackbar.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_text.dart';

class AddOptionProduct extends StatefulWidget {
  const AddOptionProduct({super.key});

  @override
  State<AddOptionProduct> createState() => _AddOptionProductState();
}

class _AddOptionProductState extends State<AddOptionProduct> {
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        leading: const WidgetBackButton(),
        title: const WidgetText(data: 'ใส่ชื่อตัวเลือก'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Obx(() {
            return appController.optionModels.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    itemCount: appController.optionModels.length,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => GFCard(
                      color: ColorPlate.back2,
                      padding: const EdgeInsets.all(4),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WidgetText(
                                  data:
                                      appController.optionModels[index].title),
                              GFIconButton(
                                icon: const Icon(Icons.delete_forever),
                                onPressed: () {},
                                type: GFButtonType.transparent,
                              )
                            ],
                          ),
                          Obx(() {
                            return WidgetText(
                                data:
                                    '${appController.optionModels[index].subOptions}');
                          }),
                          GFButton(
                            onPressed: () {
                              Get.to(AddSubOptionForm(
                                indexOptionModel: index,
                              ));
                            },
                            text: '+ เพิ่ม',
                            type: GFButtonType.outline,
                          )
                        ],
                      ),
                    ),
                  );
          }),
          GFButton(
            onPressed: () {
              if (appController.optionModels.isEmpty) {
                Get.to(const AddOptionProductForm());
              } else if (appController
                  .optionModels.last.subOptions.isNotEmpty) {
                Get.to(const AddOptionProductForm());
              } else {
                AppSnackBar(title: 'เพิ่ม', message: 'เพิ่ม SubOption')
                    .errorSnackBar();
              }
            },
            fullWidthButton: true,
            text: '+ เพิ่มชื่อตัวเลือก',
            type: GFButtonType.outline2x,
            textStyle: AppConstant().bodyStyle(
                color: GFColors.PRIMARY,
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
        ],
      ),
      bottomSheet: GFButton(
        onPressed: () {},text: 'กำหนดราคา และ สต๊อก',fullWidthButton: true,
      ),
    );
  }
}
