import 'package:flutter/material.dart';
import 'package:xstream/pages/page_affilitate.dart';
import 'package:xstream/pages/page_product.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/views/widget_text.dart';

class ManageProduct extends StatefulWidget {
  const ManageProduct({super.key});

  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  var titles = <String>[
    'สินค้าของฉัน',
    'Affiliate',
  ];
  var widgets = <Widget>[
    const PageProduct(),
    const PageAffiliate(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: titles.length,
          initialIndex: 0,
          child: Scaffold(
            appBar: TabBar(
                  tabs: titles
                      .map(
                        (e) => WidgetText(
                          data: e,
                          textStyle: AppConstant().bodyStyle(fontSize: 18),
                        ),
                      )
                      .toList()),
            body: TabBarView(children: widgets),
          ),
        ),
      ),
    );
  }
}
