// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tapped/tapped.dart';

import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_text.dart';

import 'selectText.dart';

class TikTokHeader extends StatefulWidget {
  final Function? onSearch;
  final Function? onDiscover;
  const TikTokHeader({
    Key? key,
    this.onSearch,
    this.onDiscover,
  }) : super(key: key);

  @override
  _TikTokHeaderState createState() => _TikTokHeaderState();
}

class _TikTokHeaderState extends State<TikTokHeader> {
  int currentSelect = 0;
  @override
  Widget build(BuildContext context) {
    // List<String> list = ['Live', 'ForYou'];
    List<String> list = ['', ''];
    List<Widget> headList = [];
    for (var i = 0; i < list.length; i++) {
      headList.add(Expanded(
        child: GestureDetector(
          child: Container(
            child: SelectText(
              title: list[i],
              isSelect: i == currentSelect,
            ),
          ),
          onTap: () {
            setState(() {
              currentSelect = i;
            });
          },
        ),
      ));
    }
    Widget headSwitch = Row(
      children: headList,
    );
    return Container(
      // color: Colors.black.withOpacity(0.3),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Tapped(
              child: Container(
                color: Colors.black.withOpacity(0),
                padding: EdgeInsets.all(4),
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: Colors.white.withOpacity(0.66),
                ),
              ),
              onTap: widget.onSearch,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black.withOpacity(0),
              alignment: Alignment.center,
              child: headSwitch,
            ),
          ),
          Expanded(
            child: Tapped(
              onTap: widget.onDiscover,
              child: Container(
                color: Colors.black.withOpacity(0),
                padding: const EdgeInsets.all(4),
                alignment: Alignment.centerRight,
                child: Container(
                  child: WidgetText(data: 'นักสำรวจ'),
                ),
              ),
            ),
          ),
          // Expanded(
          //   child: Tapped(
          //     onTap: widget.onLive,
          //     child: Container(
          //       color: Colors.black.withOpacity(0),
          //       padding: const EdgeInsets.all(4),
          //       alignment: Alignment.centerRight,
          //       child: WidgetText(
          //         data: 'Live',
          //         textStyle: AppConstant().bodyStyle(
          //             color: ColorPlate.red,
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
