import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LatestUpdates extends StatefulWidget {
  @override
  _LatestUpdatesState createState() => _LatestUpdatesState();
}

class _LatestUpdatesState extends State<LatestUpdates> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<String> _favorites = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Latest'),
          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        ),
        body: Builder(builder: (BuildContext context) {
          return WebView(
            initialUrl: 'https://en.wikipedia.org/wiki/Kraken',
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          );
        }));
  }
}
