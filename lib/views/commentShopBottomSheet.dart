// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

import 'package:xstream/models/comment_model.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_image_network.dart';
import 'package:xstream/views/widget_text.dart';

class CommentShopBottomSheet extends StatefulWidget {
  const CommentShopBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<CommentShopBottomSheet> createState() => _CommentShopBottomSheetState();
}

class _CommentShopBottomSheetState extends State<CommentShopBottomSheet> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
            child: Text(
                '5 Comment',
                style: StandardTextStyle.small,
              ),
          ),
          Expanded(
            child: WidgetText(data: 'data'),
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
                      print('tap up');
                      // processAddComment(upBool: true);
                    },
                    child: const Icon(Icons.arrow_circle_up),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () async {
                      print('tap down');
                      // processAddComment(upBool: false);
                    },
                    child: const Icon(Icons.arrow_circle_down),
                  ),
                  const SizedBox(
                    width: 8,
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
    required this.commentModel,
  }) : super(key: key);

  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    var info = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          commentModel.mapComment['name'],
          style: StandardTextStyle.smallWithOpacity,
        ),
        Container(height: 2),
        Text(
          commentModel.comment,
          style: StandardTextStyle.normal,
        ),
      ],
    );
    Widget right = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          commentModel.upBool ? Icons.arrow_circle_up : Icons.arrow_circle_down,
          color: commentModel.upBool ? Colors.red : Colors.white,
        ),
      ],
    );
    right = Opacity(
      opacity: 1,
      child: right,
    );
    var avatar = Container(
      margin: EdgeInsets.fromLTRB(0, 8, 10, 8),
      child: Container(
        height: 36,
        width: 36,
        child: ClipOval(
          child: WidgetImageNetwork(
            urlImage: commentModel.mapComment['urlAvatar'],
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
          right,
        ],
      ),
    );
  }
}
