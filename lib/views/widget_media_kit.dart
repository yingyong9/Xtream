// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:xstream/style/style.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_image.dart';
import 'package:xstream/views/widget_text.dart';

class WidgetMediaKit extends StatefulWidget {
  const WidgetMediaKit({
    Key? key,
    required this.streamKey,
  }) : super(key: key);

  final String streamKey;

  @override
  State<WidgetMediaKit> createState() => _WidgetMediaKitState();
}

class _WidgetMediaKitState extends State<WidgetMediaKit> {
 

  

  // String urlVideo = 'https://html.login.in.th/webrtc/player.php?dir=d2VoYXBweQ%3D%3D&id=d2VoYXBweQ%3D%3D&showview=1';   // Old

  @override
  void initState() {
    super.initState();

    String urlVideo =
      'https://webrtc.livestreaming.in.th/wehappy/play.html?name=${widget.streamKey}&playOrder=webrtc&autoplay=true'; // New


    
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
                WidgetText(data: 'This is Media Kit --> ${widget.streamKey}'),
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
