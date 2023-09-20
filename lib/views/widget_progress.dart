import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WidgetProgress extends StatelessWidget {
  const WidgetProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        // child: LoadingAnimationWidget.flickr(
        //     leftDotColor: Colors.pink, rightDotColor: Colors.white, size: 60));
        child: LoadingAnimationWidget.discreteCircle(
            color: Colors.white, size: 100));
  }
}
