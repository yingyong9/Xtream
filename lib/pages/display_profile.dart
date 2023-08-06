// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:xstream/models/user_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/views/widget_avatar.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_image.dart';
import 'package:xstream/views/widget_text.dart';



class DisplayProfile extends StatelessWidget {
  const DisplayProfile({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetAvatar(urlImage: userModel.urlAvatar),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: 250,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: const BoxDecoration(color: ColorPlate.darkGray),
                    child: WidgetText(
                      data: userModel.name,
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: 250,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: const BoxDecoration(color: ColorPlate.darkGray),
                    child: Row(
                      children: [
                        const WidgetImage(
                          path: 'images/call.png',
                          size: 36,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        WidgetText(
                          data: userModel.phoneContact!,
                          textStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: 250,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: const BoxDecoration(color: ColorPlate.darkGray),
                    child: Row(
                      children: [
                        const WidgetImage(
                          path: 'images/line.png',
                          size: 36,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        WidgetText(
                          data: userModel.linkLine!,
                          textStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    width: 250,
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: BoxDecoration(color: ColorPlate.darkGray),
                    child: Row(
                      children: [
                        WidgetImage(
                          path: 'images/messaging.png',
                          size: 36,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        WidgetText(
                          data: userModel.linkMessaging!,
                          textStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(top: 32,left: 8,
            child: WidgetBackButton(),
          ),
        ],
      ),
    );
  }
}
