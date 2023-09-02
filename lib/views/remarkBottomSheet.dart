// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import 'package:xstream/models/comment_model.dart';
import 'package:xstream/models/remark_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_controller.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_image_network.dart';
import 'package:xstream/views/widget_text.dart';

class RemarkBottomSheet extends StatefulWidget {
  const RemarkBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<RemarkBottomSheet> createState() => _RemarkBottomSheetState();
}

class _RemarkBottomSheetState extends State<RemarkBottomSheet> {
  TextEditingController textEditingController = TextEditingController();

  AppController appController = Get.find();

  @override
  void initState() {
    super.initState();
    AppService().readAllRemark();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: ColorPlate.back1,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(4),
            height: 4,
            width: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            height: 24,
            alignment: Alignment.center,
            // color: Colors.white.withOpacity(0.2),
            child: const Text(
              'บอกเรา ว่าคุณอยากได้อะไร ? ในแอพ',
              style: StandardTextStyle.normal,
            ),
          ),
          Expanded(
            child: Obx(() {
              return appController.remarkModels.isEmpty
                  ? const SizedBox()
                  : ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: appController.remarkModels.length,
                      itemBuilder: (context, index) => _CommentRow(remarkModel: appController.remarkModels[index]),
                    );
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: WidgetForm(
              textEditingController: textEditingController,
              suffixWidget: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () async {
                      RemarkModel remarkModel = RemarkModel(
                          remark: textEditingController.text,
                          timestamp: Timestamp.fromDate(DateTime.now()),
                          mapRemark:
                              appController.currentUserModels.last.toMap());

                      FirebaseFirestore.instance
                          .collection('remark')
                          .doc()
                          .set(remarkModel.toMap())
                          .then((value) {
                        textEditingController.clear();
                        AppService().readAllRemark();
                      });
                    },
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({
    Key? key,
    required this.remarkModel,
  }) : super(key: key);

  final RemarkModel remarkModel;

  @override
  Widget build(BuildContext context) {
    var info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          remarkModel.mapRemark['name'],
          style: StandardTextStyle.smallWithOpacity,
        ),
        Container(height: 2),
        Text(
          remarkModel.remark,
          style: StandardTextStyle.normal,
        ),
      ],
    );
    // Widget right = Column(
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   children: <Widget>[
    //     Icon(
    //       commentModel.upBool ? Icons.arrow_circle_up : Icons.arrow_circle_down,
    //       color: commentModel.upBool ? Colors.red : Colors.white,
    //     ),
    //   ],
    // );
    // right = Opacity(
    //   opacity: 1,
    //   child: right,
    // );
    var avatar = Container(
      margin: EdgeInsets.fromLTRB(0, 8, 10, 8),
      child: Container(
        height: 36,
        width: 36,
        child: ClipOval(
          child: WidgetImageNetwork(
            urlImage: remarkModel.mapRemark['urlAvatar'],
            boxFit: BoxFit.cover,
          ),
        ),
      ),
    );
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: <Widget>[
          avatar,
          Expanded(child: info),
          // right,
        ],
      ),
    );
  }
}
