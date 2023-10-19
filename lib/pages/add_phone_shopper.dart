import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xstream/pages/register_shop.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_gf_button.dart';
import 'package:xstream/views/widget_text.dart';

class AddPhoneShopper extends StatelessWidget {
  const AddPhoneShopper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: ListView(
            children: [
              const Row(
                children: [
                  WidgetBackButton(),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: WidgetForm(
                  labelWidget: WidgetText(data: 'กรอกเบอร์โทรศัพย์'),
                  textInputType: TextInputType.phone,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: WidgetGfButton(
                      label: 'ขอรหัส OTP',
                      pressFunc: () {
                       
                      },
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: WidgetForm(
                  textInputType: TextInputType.number,
                  labelWidget: WidgetText(data: 'กรอกรหัส OTP'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: WidgetGfButton(
                      label: 'ยืนยัน OTP',
                      pressFunc: () {
                         Get.to(const RegisterShop());
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
