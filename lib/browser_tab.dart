import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'browser_model.dart';

class BrowserTab extends StatefulWidget {
  BrowserTab({Key? key}) : super(key: key);

  @override
  BrowserTabState createState() => BrowserTabState();
}

class BrowserTabState extends State<BrowserTab> {
  InAppWebViewController? webViewController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(value: progress),
        Expanded(
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse("https://www.google.com")),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onProgressChanged: (controller, progress) {
              setState(() {
                this.progress = progress / 100;
              });
            },
            onLoadStop: (controller, url) async {
              String? title = await controller.getTitle();
              if (title != null && title.isNotEmpty) {
                Provider.of<BrowserModel>(context, listen: false).updateTabName(title);
              }
            },
          ),
        ),
      ],
    );
  }
}
