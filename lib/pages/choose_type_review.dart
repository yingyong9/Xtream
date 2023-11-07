// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/pages/review_page.dart';

import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_image.dart';
import 'package:xstream/views/widget_text.dart';

class ChooseTypeReivew extends StatelessWidget {
  const ChooseTypeReivew({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const WidgetBackButton(),
        title: const WidgetText(data: 'เลือกประเภท'),
        backgroundColor: ColorPlate.back1,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: AppConstant.collectionPlates.length,
        itemBuilder: (context, index) => WidgetMenu(
            tapFunc: () {
              Get.to(ReviewPage(indexReviewCat: index))?.then((value) {
                Get.back(result: value);
              });
            },
            title: AppConstant.collectionPlates[index],
            subTitle: AppConstant.reviewCats[index]),
      ),
    );
  }
}

class WidgetMenu extends StatelessWidget {
  const WidgetMenu({
    super.key,
    required this.title,
    required this.subTitle,
    this.tapFunc,
  });

  final String title;
  final String subTitle;
  final Function()? tapFunc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tapFunc,
      leading: const WidgetImage(),
      title: WidgetText(
        data: title,
        textStyle: AppConstant().bodyStyle(fontSize: 20),
      ),
      subtitle: WidgetText(
        data: subTitle,
        textStyle: AppConstant().bodyStyle(fontSize: 14),
      ),
    );
  }
}
