// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xstream/pages/homePage.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_dialog.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/utility/app_snackbar.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_form_multiline.dart';
import 'package:xstream/views/widget_icon_button.dart';
import 'package:xstream/views/widget_image_file.dart';
import 'package:xstream/views/widget_text.dart';

class DetailPost extends StatefulWidget {
  const DetailPost({
    Key? key,
    required this.fileThumbnail,
    required this.fileVideo,
    required this.nameFileVideo,
    required this.nameFileImage,
  }) : super(key: key);

  final File fileThumbnail;
  final File fileVideo;
  final String nameFileVideo;
  final String nameFileImage;

  @override
  State<DetailPost> createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
  TextEditingController detailController = TextEditingController();
  AppController appController = Get.put(AppController());

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController affiliateController = TextEditingController();
  TextEditingController phoneContactController = TextEditingController();
  TextEditingController linkLineController = TextEditingController();
  TextEditingController linkMessageController = TextEditingController();

  var widgetForms = <Widget>[];

  @override
  void initState() {
    super.initState();
    if (appController.currentUserModels.isNotEmpty) {
      phoneContactController.text =
          appController.currentUserModels.last.phoneContact ?? '';
      linkLineController.text =
          appController.currentUserModels.last.linkLine ?? '';
      linkMessageController.text =
          appController.currentUserModels.last.linkMessaging ?? '';
    }

    widgetForms.add(const SizedBox());
    widgetForms.add(cameraForm());
    widgetForms.add(galleryForm());
    widgetForms.add(productForm());
  }

  Widget galleryForm() {
    return WidgetForm(
      textEditingController: nameController,
      labelWidget: const WidgetText(data: 'อยากบอกอะไร'),
    );
  }

  Widget cameraForm() {
    return WidgetForm(
      textEditingController: nameController,
      labelWidget: const WidgetText(data: 'อยากบอกอะไร'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPlate.back1,
        leading: WidgetBackButton(
          pressFunc: () {
            Get.offAll(const HomePage());
          },
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SizedBox(
              width: boxConstraints.maxWidth,
              height: boxConstraints.maxHeight,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: boxConstraints.maxWidth * 0.75 - 16,
                        child: WidgetFormMultiLine(
                          textEditingController: detailController,
                          hint: 'กรอกข้อความ',
                          maxLines: 5,
                        ),
                      ),
                      SizedBox(
                        width: boxConstraints.maxWidth * 0.25,
                        height: boxConstraints.maxWidth * 0.35,
                        child: WidgetImageFile(fileImage: widget.fileThumbnail),
                      ),
                    ],
                  ),
                  const Divider(
                    color: ColorPlate.gray,
                  ),
                  Row(
                    children: [
                      WidgetIconButton(
                        iconData: Icons.camera_alt_outlined,
                        pressFunc: () {
                          AppService().processTakePhoto(
                              imageSource: ImageSource.camera);
                          appController.indexForm.value = 1;
                        },
                        size: 36,
                      ),
                      WidgetIconButton(
                        iconData: Icons.image_outlined,
                        pressFunc: () {
                          AppService().processTakePhoto(
                              imageSource: ImageSource.gallery);
                          appController.indexForm.value = 2;
                        },
                        size: 36,
                      ),
                      WidgetIconButton(
                        iconData: Icons.shopping_cart_outlined,
                        pressFunc: () {
                          AppService().processTakePhoto(
                              imageSource: ImageSource.gallery);
                          appController.indexForm.value = 3;
                        },
                        size: 36,
                      ),
                    ],
                  ),
                  Obx(() {
                    return appController.files.isEmpty
                        ? const SizedBox()
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: boxConstraints.maxWidth * 0.65,
                                child:
                                    widgetForms[appController.indexForm.value],
                              ),
                              SizedBox(
                                width: boxConstraints.maxWidth * 0.25,
                                height: boxConstraints.maxWidth * 0.35,
                                child: WidgetImageFile(
                                    fileImage: appController.files.last),
                              ),
                            ],
                          );
                  })
                ],
              ),
            ),
          );
        }),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(color: ColorPlate.back1),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: double.infinity,
        child: WidgetButton(
          color: ColorPlate.red,
          label: 'โพสต์',
          pressFunc: () async {
            AppDialog().dialogProgress();

            if (appController.files.isEmpty) {
              // Video Only

              String? urlImage = await AppService().processUploadThumbnailVideo(
                  fileThumbnail: widget.fileThumbnail,
                  nameFile: widget.nameFileImage);

              AppService()
                  .processFtpUploadAndInsertDataVideo(
                      fileVideo: widget.fileVideo,
                      nameFileVideo: widget.nameFileVideo,
                      urlThumbnail: urlImage!,
                      detail: detailController.text)
                  .then((value) => Get.back());
            } else {
              // Have Product

              if ((nameController.text.isEmpty) ||
                  (priceController.text.isEmpty) ||
                  (affiliateController.text.isEmpty)) {
                Get.back();
                AppSnackBar(
                        title: 'มีช่องว่าง',
                        message: 'ชื่อ, ราคา และ นายหน้าสินค้า ต้องมี')
                    .errorSnackBar();
              } else {
                String? urlImageProduct =
                    await AppService().processUploadFile(path: 'product');

                String? urlImage = await AppService()
                    .processUploadThumbnailVideo(
                        fileThumbnail: widget.fileThumbnail,
                        nameFile: widget.nameFileImage);

                AppService()
                    .processFtpUploadAndInsertDataVideo(
                      fileVideo: widget.fileVideo,
                      nameFileVideo: widget.nameFileVideo,
                      urlThumbnail: urlImage!,
                      detail: detailController.text,
                      nameProduct: nameController.text,
                      priceProduct: priceController.text,
                      stockProduct: stockController.text,
                      affiliateProduct: affiliateController.text,
                      urlProduct: urlImageProduct,
                    )
                    .then((value) => Get.back());
              }
            }
          },
        ),
      ),
    );
  }

  Widget productForm() {
    return Column(
      children: [
        WidgetForm(
          textEditingController: nameController,
          labelWidget: const WidgetText(data: 'ชื่อสินค้า :'),
        ),
        const SizedBox(
          height: 8,
        ),
        WidgetForm(
          textEditingController: priceController,
          labelWidget: const WidgetText(data: 'ราคาสินค้า :'),
        ),
        const SizedBox(
          height: 8,
        ),
        WidgetForm(
          textEditingController: stockController,
          labelWidget: const WidgetText(data: 'จำนวนสินค้า :'),
        ),
        const SizedBox(
          height: 8,
        ),
        WidgetForm(
          textEditingController: affiliateController,
          labelWidget: const WidgetText(data: 'นายหน้า :'),
        ),
        const SizedBox(
          height: 8,
        ),
        // WidgetForm(
        //   textEditingController:
        //       phoneContactController,
        //   hint: 'phone',
        //   prefixWidget: const Column(
        //     mainAxisAlignment:
        //         MainAxisAlignment.center,
        //     children: [
        //       WidgetImage(
        //         path: 'images/call.png',
        //         size: 36,
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(
        //   height: 8,
        // ),
        // WidgetForm(
        //   textEditingController: linkLineController,
        //   hint: 'LinkLine',
        //   prefixWidget: const Column(
        //     mainAxisAlignment:
        //         MainAxisAlignment.center,
        //     children: [
        //       WidgetImage(
        //         path: 'images/line.png',
        //         size: 36,
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(
        //   height: 8,
        // ),
        // WidgetForm(
        //   textEditingController:
        //       linkMessageController,
        //   hint: 'LinkMessaging',
        //   prefixWidget: Column(
        //     mainAxisAlignment:
        //         MainAxisAlignment.center,
        //     children: [
        //       WidgetImage(
        //         path: 'images/messaging.png',
        //         size: 36,
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(
        //   height: 8,
        // ),
        const SizedBox(
          height: 64,
        )
      ],
    );
  }
}
