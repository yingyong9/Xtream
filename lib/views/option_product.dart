import 'package:flutter/material.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_form.dart';

class OptionProduct extends StatelessWidget {
  const OptionProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(heightFactor: 0.75,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            WidgetForm(
              hint: 'สี หรือ ตัวเลือก',
            ),
            SizedBox(
              height: 16,
            ),
            WidgetForm(
              hint: 'ขนาด',
            ),
            SizedBox(
              height: 16,
            ),
            WidgetForm(
              hint: 'ราคา',
            ),
            SizedBox(
              height: 16,
            ),
            WidgetForm(
              hint: 'จำนวน',
            ),
            SizedBox(
              height: 16,
            ),
            WidgetButton(
              label: 'Add',
              pressFunc: () {},
            )
          ],
        ),
      ),
    );
  }
}
