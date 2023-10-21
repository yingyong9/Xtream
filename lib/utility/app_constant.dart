import 'package:flutter/material.dart';
import 'package:xstream/style/style.dart';

class AppConstant {
  static List<String> reviewCats = <String>[
    'อาหาร',
    'ท่องเทียว/ทัวร์',
    'ที่พัก',
  ];

  static List<String> collectionPlates = <String>['Food','Travel','Hotel',];

  static String host = 'stream115.otaro.co.th';
  static String user = 'adminftp';
  static String pass = 'c@WS83m4&C3j';

  static String key = '1758532022818591';
  static String secret = '6ee4cbc8611eaa7c3e4ed60b071badf7';
  static String urlAvatar =
      'https://firebasestorage.googleapis.com/v0/b/xstream-c6c77.appspot.com/o/profile%2Flogo2.png?alt=media&token=276e4855-fa85-4fa1-80d0-ce3aec46e4bf';
  static String urlAccount =
      'https://firebasestorage.googleapis.com/v0/b/xstream-c6c77.appspot.com/o/profile%2F285655_user_icon.png?alt=media&token=681e8b4e-0a7b-4435-b088-476f679f7343';

  static String urlStream =
      'https://webrtc.livestreaming.in.th/wehappy/play.html?name=wehappy&playOrder=webrtc&autoplay=true';
  static String streamKey = 'wehappy';

  TextStyle? h1Style({required BuildContext context, double? size}) {
    return Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: size);
  }

  TextStyle bodyStyle(
          {FontWeight? fontWeight, double? fontSize, Color? color}) =>
      TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? SysSize.small,
        color: color ?? ColorPlate.white,
      );
}
