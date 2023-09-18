// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:xstream/style/style.dart';
import 'package:xstream/utility/app_service.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_image.dart';
import 'package:xstream/views/widget_text.dart';

class WidgetWebView extends StatefulWidget {
  const WidgetWebView({
    Key? key,
    required this.streamKey,
  }) : super(key: key);

  final String streamKey;

  @override
  State<WidgetWebView> createState() => _WidgetWebViewState();
}

class _WidgetWebViewState extends State<WidgetWebView> {
  WebViewController? webViewController;

  // String urlVideo = 'https://html.login.in.th/webrtc/player.php?dir=d2VoYXBweQ%3D%3D&id=d2VoYXBweQ%3D%3D&showview=1';   // Old

  @override
  void initState() {
    super.initState();

    String urlVideo =
        'https://webrtc.livestreaming.in.th/wehappy/play.html?name=${widget.streamKey}&playOrder=webrtc&autoplay=true'; // New

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(ColorPlate.back1)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {},
        onPageStarted: (url) {},
        onPageFinished: (url) {},
        onWebResourceError: (error) {},
        onNavigationRequest: (request) {
          if (request.url.startsWith('https://www.androidthai.in.th')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(urlVideo));
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
                WebViewWidget(controller: webViewController!),
                const Positioned(
                  top: 32,
                  left: 16,
                  child: WidgetBackButton(),
                ),
                Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: () {
                      print('you tap');
                    },
                    child: Container(
                      width: boxConstraints.maxWidth * 0.6,
                      height: 40,
                      decoration: BoxDecoration(color: Colors.black),
                      child: Text(''),
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
