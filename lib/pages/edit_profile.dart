import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_avatar.dart';
import 'package:xstream/views/widget_avatar_file.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_form_line.dart';
import 'package:xstream/views/widget_icon_button.dart';
import 'package:xstream/views/widget_image.dart';
import 'package:xstream/views/widget_text.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  AppController controller = Get.put(AppController());

  TextEditingController textEditingController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lineController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  bool change = false;

  @override
  void initState() {
    super.initState();
    textEditingController.text = controller.currentUserModels.last.name;
    phoneController.text = controller.currentUserModels.last.phoneContact!;
    lineController.text = controller.currentUserModels.last.linkLine!;
    messageController.text = controller.currentUserModels.last.linkMessaging!;

    if (controller.files.isNotEmpty) {
      controller.files.clear();
    }

    controller.change.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        elevation: 0,
        title: WidgetText(data: 'แก้ไขโปรไฟล์'),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GetX(
            init: AppController(),
            builder: (AppController appController) {
              return appController.currentUserModels.isEmpty
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          displayAvatar(appController),
                          const SizedBox(
                            height: 8,
                          ),
                          nameForm(),
                          const SizedBox(
                            height: 8,
                          ),
                          callForm(),
                          const SizedBox(
                            height: 8,
                          ),
                          lineForm(),
                          const SizedBox(
                            height: 8,
                          ),
                          messagingForm(),
                          const SizedBox(
                            height: 48,
                          ),
                        ],
                      ),
                    );
            });
      }),
      bottomSheet: Container(
        decoration: BoxDecoration(color: ColorPlate.back1),
        width: double.infinity,
        child: WidgetButton(
          color: ColorPlate.red,
          label: 'บันทึก',
          pressFunc: () async {
            if (controller.change.value) {
              Map<String, dynamic> map =
                  controller.currentUserModels.last.toMap();

              map['name'] = textEditingController.text;
              map['phoneContact'] = phoneController.text;
              map['linkLine'] = lineController.text;
              map['linkMessaging'] = messageController.text;

              print('files ---> ${controller.files.length}');

              if (controller.files.isEmpty) {
                //Non Change Avatar
                AppService().processEditProfile(map: map);
              } else {
                //Change Avagar
                print('##26july map before ----> $map');
                String? urlAvatar =
                    await AppService().processUploadFile(path: 'profile');
                map['urlAvatar'] = urlAvatar ?? AppConstant.urlAvatar;
                 print('##26july map ----> $map');
                AppService().processEditProfile(map: map);
              }
            }
          },
        ),
      ),
    );
  }

  Row messagingForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: WidgetFormLine(
            changeFunc: (p0) {
              controller.change.value = true;
            },
            textEditingController: messageController,
            hint: 'Facebook Messaging',
            prefixWidget: WidgetImage(
              size: 20,
              path: 'images/messaging.png',
            ),
          ),
        ),
      ],
    );
  }

  Row lineForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: WidgetFormLine(
            changeFunc: (p0) {
              controller.change.value = true;
            },
            textEditingController: lineController,
            hint: 'Link Line',
            prefixWidget: WidgetImage(
              size: 20,
              path: 'images/line.png',
            ),
          ),
        ),
      ],
    );
  }

  Row callForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: WidgetFormLine(
            changeFunc: (p0) {
              controller.change.value = true;
            },
            textEditingController: phoneController,
            hint: 'เบอร์โทร',
            prefixWidget: WidgetImage(
              size: 20,
              path: 'images/call.png',
            ),
          ),
        ),
      ],
    );
  }

  Row nameForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          child: WidgetFormLine(
            changeFunc: (p0) {
              controller.change.value = true;
            },
            textEditingController: textEditingController,
            labelWidget: WidgetText(data: 'ชื่อ'),
          ),
        ),
      ],
    );
  }

  Row displayAvatar(AppController appController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: appController.files.isEmpty
                  ? WidgetAvatar(
                      urlImage: appController.currentUserModels.last.urlAvatar,
                    )
                  : WidgetAvatarFile(file: appController.files.last),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: WidgetIconButton(
                iconData: Icons.camera_alt_outlined,
                pressFunc: () {
                  AppService().processTakePhoto();
                  controller.change.value = true;
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
