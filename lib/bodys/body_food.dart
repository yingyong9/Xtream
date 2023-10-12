// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:xstream/views/widget_ratting.dart';

class BodyFood extends StatelessWidget {
  const BodyFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WidgetRatingStar(title: 'โดยรวม', sizeIcon: 30,),
        WidgetRatingStar(title: 'รสชาติ',),
        WidgetRatingStar(title: 'สิ่งแวดล้อม',),
        WidgetRatingStar(title: 'บริการ',),
        WidgetRatingStar(title: 'วัตถุดิบ',),
        
      ],
    );
  }
}
