// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:xstream/views/widget_back_button.dart';

class BigImage extends StatelessWidget {
  const BigImage({
    Key? key,
    required this.urlImage,
  }) : super(key: key);

  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            PhotoView(imageProvider: NetworkImage(urlImage)),
            Positioned(top: 32,left: 16,
              child: WidgetBackButton(),
            ),
          ],
        ),
      ),
    );
  }
}
