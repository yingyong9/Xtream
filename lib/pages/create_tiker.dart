import 'package:flutter/material.dart';
import 'package:xstream/utility/app_constant.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: WidgetForm(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  // width: 150,
                  child: WidgetRatingStarOnly(
                    ratingUpdateFunc: (p0) {},
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetGfButton(
                  label: 'เพิ่ม Tiker',
                  pressFunc: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
