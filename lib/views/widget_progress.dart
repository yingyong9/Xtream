import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WidgetProgress extends StatelessWidget {
  const WidgetProgress({key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.flickr(
            leftDotColor: Colors.pink, rightDotColor: Colors.white, size: 60));
  }
}
