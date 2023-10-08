// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xstream/pages/add_option_product.dart';
import 'package:xstream/pages/homePage.dart';
import 'package:xstream/pages/manage_product.dart';
import 'package:xstream/pages/review_page.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_constant.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_dialog.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/option_product.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_form_multiline.dart';
import 'package:xstream/views/widget_icon_button.dart';
import 'package:xstream/views/widget_image_file.dart';
import 'package:xstream/views/widget_text.dart';
import 'package:xstream/views/widget_text_button.dart';

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

  TextEditingController liveController = TextEditingController();

  var widgetForms = <Widget>[];

  @override
  void initState() {
    super.initState();

    appController.liveBool.value = false;

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
      appBar: mainAppbar(),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
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
                    Column(
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
                        // Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   children: [
                        //     displayIcon(),
                        //     displayIcon2(),
                        //   ],
                        // ),
                      ],
                    ),
                    SizedBox(
                      width: boxConstraints.maxWidth * 0.25,
                      height: boxConstraints.maxWidth * 0.35 + 36,
                      child: WidgetImageFile(fileImage: widget.fileThumbnail),
                    ),
                  ],
                ),
                const Divider(
                  color: ColorPlate.gray,
                ),
                displayImageFile(boxConstraints),
                displayLive(boxConstraints: boxConstraints),
                Row(
                  children: [
                    WidgetTextButton(
                      label: 'Review',
                      pressFunc: () {
                        Get.to(const ReviewPage());
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
      bottomSheet: Container(
        decoration: const BoxDecoration(color: ColorPlate.back1),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        width: double.infinity,
        child: WidgetButton(
          color: ColorPlate.red,
          label: 'โพสต์',
          pressFunc: () async {
            AppDialog().dialogProgress();

            if (appController.liveBool.value) {
              String? urlImageLive =
                  await AppService().processUploadFileImageLive(path: 'live');

              String? urlImage = await AppService().processUploadThumbnailVideo(
                  fileThumbnail: widget.fileThumbnail,
                  nameFile: widget.nameFileImage);

              AppService()
                  .processFtpUploadAndInsertDataVideo(
                fileVideo: widget.fileVideo,
                nameFileVideo: widget.nameFileVideo,
                urlThumbnail: urlImage!,
                detail: '',
                urlImagelive: urlImageLive,
                liveTitle: liveController.text,
                startLive: Timestamp.fromDate(DateTime.now()),
              )
                  .then((value) {
                // Get.back();

                AppService().processLaunchPrismLive();
              });
            } else if (appController.files.isEmpty) {
              // Video Only

              await insertVideoOnly();
            } else {
              // Have Product

              String? urlImageProduct =
                  await AppService().processUploadFile(path: 'product');

              String? urlImage = await AppService().processUploadThumbnailVideo(
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
          },
        ),
      ),
    );
  }

  Future<void> insertVideoOnly() async {
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
  }

  AppBar mainAppbar() {
    return AppBar(
      backgroundColor: ColorPlate.back1,
      leading: WidgetBackButton(
        pressFunc: () {
          Get.offAll(const HomePage());
        },
      ),
      elevation: 0,
    );
  }

  Obx displayLive({required BoxConstraints boxConstraints}) {
    return Obx(() {
      return appController.liveBool.value
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: boxConstraints.maxWidth * 0.65,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          WidgetForm(
                            textEditingController: liveController,
                            labelWidget: const WidgetText(data: 'ข้อความ'),
                          ),
                          const WidgetText(data: '* คุณมีเวลา Live 2 ชัวโมง *'),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        AppService().processTakePhotoLive(
                            imageSource: ImageSource.gallery);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorPlate.gray,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        width: boxConstraints.maxWidth * 0.25,
                        height: boxConstraints.maxWidth * 0.35,
                        child: appController.liveFiles.isEmpty
                            ? const WidgetText(data: 'Add Image')
                            : WidgetImageFile(
                                fileImage: appController.liveFiles.last),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    WidgetText(
                      data: 'ค่า RTMP ของคุณ',
                      textStyle: AppConstant().bodyStyle(fontSize: 20),
                    ),
                  ],
                ),
                ListTile(
                  title: WidgetText(
                    data: 'Stream name',
                    textStyle: AppConstant().bodyStyle(
                      fontSize: 14,
                    ),
                  ),
                  subtitle: WidgetText(
                    data: 'WeHappy',
                    textStyle: AppConstant().bodyStyle(fontSize: 18),
                  ),
                  trailing: WidgetIconButton(
                    iconData: Icons.copy,
                    pressFunc: () {
                      Clipboard.setData(const ClipboardData(text: 'WeHappy'));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetText(
                            data: 'Stream URL',
                            textStyle: AppConstant().bodyStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: WidgetText(
                              maxLines: 2,
                              data:
                                  'rtmp://wehappy.webrtc.livestreaming.in.th/wehappy/',
                              textStyle: AppConstant().bodyStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      WidgetIconButton(
                        iconData: Icons.copy,
                        pressFunc: () {
                          Clipboard.setData(const ClipboardData(
                              text:
                                  'rtmp://wehappy.webrtc.livestreaming.in.th/wehappy/'));
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: WidgetText(
                    data: 'Stream key',
                    textStyle: AppConstant().bodyStyle(
                      fontSize: 14,
                    ),
                  ),
                  subtitle: WidgetText(
                    data: appController.currentUserModels.last.uid
                        .substring(0, 6),
                    textStyle: AppConstant().bodyStyle(fontSize: 18),
                  ),
                  trailing: WidgetIconButton(
                    iconData: Icons.copy,
                    pressFunc: () {
                      Clipboard.setData(ClipboardData(
                          text: appController.currentUserModels.last.uid
                              .substring(0, 6)
                              .toString()));
                    },
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            )
          : const SizedBox();
    });
  }

  Obx displayImageFile(BoxConstraints boxConstraints) {
    return Obx(() {
      return appController.files.isEmpty
          ? const SizedBox()
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: boxConstraints.maxWidth * 0.65,
                  child: widgetForms[appController.indexForm.value],
                ),
                SizedBox(
                  width: boxConstraints.maxWidth * 0.25,
                  height: boxConstraints.maxWidth * 0.35,
                  child: WidgetImageFile(fileImage: appController.files.last),
                ),
              ],
            );
    });
  }

  Row displayIcon() {
    return Row(
      children: [
        WidgetIconButton(
          iconData: Icons.shopping_basket,
          pressFunc: () {
            Get.to(const ManageProduct());

            // AppService().processTakePhoto(imageSource: ImageSource.gallery);
            // appController.indexForm.value = 3;
          },
          size: 24,
        ),
      ],
    );
  }

  Row displayIcon2() {
    return Row(
      children: [
        WidgetTextButton(
          label: 'Live',
          textStyle: AppConstant().bodyStyle(
              color: ColorPlate.red, fontSize: 20, fontWeight: FontWeight.w700),
          pressFunc: () {
            appController.liveBool.value = true;
          },
        ),
      ],
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
        WidgetTextButton(
          label: 'เพิ่มตัวเลือก',
          pressFunc: () {
            if (appController.optionModels.isNotEmpty) {
              appController.optionModels.clear();
            }

            Get.to(const AddOptionProduct());

            // Get.bottomSheet(
            //   OptionProduct(),
            //   isScrollControlled: true,
            // );
          },
        ),
        const SizedBox(
          height: 64,
        )
      ],
    );
  }
}
