// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_image.dart';
import 'package:xstream/views/widget_text.dart';

class WidgetPlayerVideo extends StatefulWidget {
  const WidgetPlayerVideo({
    Key? key,
    required this.streamKey,
  }) : super(key: key);

  final String streamKey;

  @override
  State<WidgetPlayerVideo> createState() => _WidgetPlayerVideoState();
}

class _WidgetPlayerVideoState extends State<WidgetPlayerVideo> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();

    String urlVideo =
        'https://webrtc.livestreaming.in.th/wehappy/play.html?name=${widget.streamKey}&playOrder=webrtc&autoplay=true'; // New

    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(urlVideo))
          ..initialize()
          ..play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return SafeArea(
          child: SizedBox(
            width: boxConstraints.maxWidth,
            height: boxConstraints.maxHeight,
            child: Stack(
              children: [
                VideoPlayer(videoPlayerController!),
                const Positioned(
                  top: 32,
                  left: 16,
                  child: WidgetBackButton(),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: boxConstraints.maxWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const WidgetImage(
                          path: 'images/barketwhite.png',
                          size: 36,
                        ),
                        const SizedBox(
                          width: 100,
                          child: WidgetForm(),
                        ),
                        WidgetButton(
                          label: 'เลือกช่อง',
                          pressFunc: () {},
                        ),
                        WidgetButton(
                          label: 'Live',
                          pressFunc: () async {
                            await LaunchApp.openApp(
                              androidPackageName: 'com.prism.live',
                              iosUrlScheme: '',
                              appStoreLink:
                                  'https://apps.apple.com/app/id1319056339',
                            ).catchError((onError) {
                              print(onError.toString());
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
