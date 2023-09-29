import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:xstream/models/chat_comment_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_text.dart';

class ChatCommentBottomSheet extends StatefulWidget {
  const ChatCommentBottomSheet({super.key});

  @override
  State<ChatCommentBottomSheet> createState() => _ChatCommentBottomSheetState();
}

class _ChatCommentBottomSheetState extends State<ChatCommentBottomSheet> {
  TextEditingController textEditingController = TextEditingController();
  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
      return Container(
        color: ColorPlate.back1,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: boxConstraints.maxWidth - 80,
              child: WidgetForm(
                textEditingController: textEditingController,
                autofocus: true,
                suffixWidget: GFIconButton(
                  icon: Icon(Icons.image),
                  type: GFButtonType.transparent,
                  onPressed: () {},
                ),
              ),
            ),
            GFIconButton(
              icon: const Icon(Icons.send),
              type: GFButtonType.transparent,
              onPressed: () async {
                if (textEditingController.text.isNotEmpty) {
                  ChatCommentModel chatCommentModel = ChatCommentModel(
                      comment: textEditingController.text,
                      timestamp: Timestamp.fromDate(DateTime.now()),
                      mapComment: appController.currentUserModels.last.toMap());

                  // print('chatCommentModel ----> ${chatCommentModel.toMap()}');

                  String docIdVideo =
                      appController.docIdVideos[appController.indexVideo.value];

                  print('docIdVideo ---> $docIdVideo');

                  FirebaseFirestore.instance
                      .collection('video')
                      .doc(docIdVideo)
                      .collection('comment')
                      .doc()
                      .set(chatCommentModel.toMap())
                      .then((value) {
                        Get.back();
                      });
                }

               
              },
            )
          ],
        ),
      );
    });
  }
}
