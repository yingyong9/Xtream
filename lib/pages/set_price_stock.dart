// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:xstream/views/widget_text.dart';

class SetPriceStock extends StatelessWidget {
  const SetPriceStock({
    Key? key,
    required this.titles,
  }) : super(key: key);

  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(itemCount: titles.length,
          itemBuilder: (context, index) => WidgetText(data: titles[index]),
        ),
      ),
    );
  }
}
