// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pin_code_widget/flutter_pin_code_widget.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:restart_app/restart_app.dart';
import 'package:xstream/models/otp_require_thaibulk.dart';
import 'package:xstream/pages/homePage.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_form_line.dart';
import 'package:xstream/views/widget_icon_button_gf.dart';
import 'package:xstream/views/widget_image.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';

class CheckPincode extends StatefulWidget {
  const CheckPincode({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  final String phoneNumber;

  @override
  State<CheckPincode> createState() => _CheckPincodeState();
}

class _CheckPincodeState extends State<CheckPincode> {
  OtpRequireThaibulk? otpRequireThaibulk;

  OtpFieldController otpFieldController = OtpFieldController();

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppService()
        .processSentSmsThaibulk(phoneNumber: widget.phoneNumber)
        .then((value) {
      print('value ---> ${value.toMap()}');
      otpRequireThaibulk = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
          LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return Stack(
          children: [
            Column(
              children: [
                // displayLogo(boxConstraints),
                const SizedBox(
                  height: 50,
                ),
                displayTitle(),

                SizedBox(
                  width: 250,
                  child: WidgetFormLine(textEditingController: textEditingController,
                    hint: 'กรอกรหัส OTP',
                    suffixWidget: WidgetIconButtonGF(
                      iconData: Icons.clear,
                      pressFunc: () {},
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                 SizedBox(
                  width: 250,
                  child: WidgetButton(
                    label: 'ยืนยัน',
                    pressFunc: () {},
                    color: ColorPlate.red,
                    gfButtonShape: GFButtonShape.pills,
                  ),
                ),

                const SizedBox(
                  height: 150,
                ),

                WidgetTextButton(
                  label: 'ขอรหัส OTP ใหม่',
                  pressFunc: () {},
                )

                // OTPTextField(
                //   fieldStyle: FieldStyle.underline,
                //   length: 6,
                //   width: 250,
                //   style: const TextStyle(
                //     fontSize: 24,
                //   ),
                //   otpFieldStyle: OtpFieldStyle(
                //       borderColor: Colors.white,
                //       enabledBorderColor: Colors.white),
                //   onCompleted: (value) async {
                //     if (widget.phoneNumber == '0818595309') {
                //       await FirebaseAuth.instance
                //           .signInWithEmailAndPassword(
                //               email: 'email${widget.phoneNumber}@xstream.com',
                //               password: '123456')
                //           .then((value) {
                //         if (GetPlatform.isAndroid) {
                //           Restart.restartApp();
                //         } else {
                //           AppService()
                //               .findCurrentUserModel()
                //               .then((value) => Get.offAll(const HomePage()));
                //         }
                //       });
                //     } else {
                //       AppService().verifyOTPThaibulk(
                //           token: otpRequireThaibulk!.token,
                //           pin: value,
                //           context: context,
                //           phoneNumber: widget.phoneNumber);
                //     }
                //   },
                // ),
              ],
            ),
            const WidgetBackButton(),
          ],
        );
      })),
    );
  }

  Row displayTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          margin: const EdgeInsets.only(bottom: 32),
          child: WidgetText(
            data: 'กรอกรหัสยืนยัน',
            textStyle: AppConstant().bodyStyle(fontSize: 30),
          ),
        ),
      ],
    );
  }

  SizedBox displayLogo(BoxConstraints boxConstraints) {
    return SizedBox(
      width: boxConstraints.maxWidth,
      height: boxConstraints.maxHeight * 0.25,
      child: WidgetImage(),
    );
  }
}
