
import 'package:flutter/material.dart';
import 'package:tapped/tapped.dart';
import 'package:xstream/style/style.dart';

class UserMsgRow extends StatelessWidget {
  final Widget? lead;
  final String? title;
  final String? desc;
  final bool reverse;
  const UserMsgRow({
    Key? key,
    this.title,
    this.desc,
    this.reverse = false,
    this.lead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[
      Text(
        title ?? '用户',
        style: StandardTextStyle.normalW,
      ),
      Container(height: 2),
      Text(
        desc ?? '和你打了下招呼',
        style: StandardTextStyle.smallWithOpacity,
      ),
    ];
    var info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: reverse ? list.reversed.toList() : list,
    );
    var right = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '10-12',
          style: StandardTextStyle.smallWithOpacity,
        ),
      ],
    );
    var avatar = Container(
      margin: EdgeInsets.fromLTRB(0, 8, 10, 8),
      child: Container(
        height: 40,
        width: 40,
        child: lead ??
            ClipOval(
              child: Image.asset('images/logo3.png', fit: BoxFit.cover,),
            ),
      ),
    );
    return Tapped(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          children: <Widget>[
            avatar,
            Expanded(child: info),
            right,
          ],
        ),
      ),
    );
  }
}
