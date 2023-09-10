import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xstream/style/style.dart';
import 'package:xstream/views/widget_back_button.dart';
import 'package:xstream/views/widget_button.dart';
import 'package:xstream/views/widget_form.dart';
import 'package:xstream/views/widget_image.dart';
import 'package:xstream/views/widget_text.dart';

class WatchLiveVideo extends StatefulWidget {
  const WatchLiveVideo({super.key});

  @override
  State<WatchLiveVideo> createState() => _WatchLiveVideoState();
}

class _WatchLiveVideoState extends State<WatchLiveVideo> {
  WebViewController? webViewController;

   String urlVideo = 'https://webrtc.livestreaming.in.th/wehappy/play.html?name=wehappy&playOrder=webrtc&autoplay=true';   // New

  // String urlVideo = 'https://html.login.in.th/webrtc/player.php?dir=d2VoYXBweQ%3D%3D&id=d2VoYXBweQ%3D%3D&showview=1';   // Old

  @override
  void initState() {
    super.initState();
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
