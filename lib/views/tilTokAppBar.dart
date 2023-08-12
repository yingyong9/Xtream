// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:xstream/style/style.dart';

import 'backButton.dart';

class TikTokSwitchAppbar extends StatelessWidget {
  final int? index;
  final List<String>? list;
  final Function(int)? onSwitch;

  const TikTokSwitchAppbar({
    Key? key,
    this.index,
    this.list,
    this.onSwitch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> body = [];
    for (var i = 0; i < list!.length; i++) {
      body.add(
        GestureDetector(
          onTap: () => onSwitch?.call(i),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text(
              list![i],
              style: index == i
                  ? StandardTextStyle.big
                  : StandardTextStyle.bigWithOpacity,
            ),
          ),
        ),
      );
    }
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: ColorPlate.back2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: body,
      ),
    );
  }
}

class TikTokAppbar extends StatelessWidget {
  const TikTokAppbar({
    Key? key,
    required this.title,
    this.displayBack,
  }) : super(key: key);

  final String? title;
  final bool? displayBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: ColorPlate.back2,
      width: double.infinity,
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: <Widget>[
            displayBack ?? true ? IosBackButton() : const SizedBox(height: 50,),
            Expanded(
              child: Text(
                title ?? '',
                textAlign: TextAlign.center,
                style: StandardTextStyle.big,
              ),
            ),
            const Opacity(
              opacity: 0,
              child: Icon(
                Icons.panorama_fish_eye,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
