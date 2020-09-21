import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LatestUpdates extends StatefulWidget {
  final String url;
  LatestUpdates(this.url);
  @override
  _LatestUpdatesState createState() => _LatestUpdatesState();
}

class _LatestUpdatesState extends State<LatestUpdates> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Latest'),
        ),
        body: Builder(builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              WebView(
                initialUrl: widget.url,
                onPageFinished: (String url) {
                  setState(() {
                    loading = false;
                  });
                },
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
              ),
              loading
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[CircularProgressIndicator()],
                      ),
                    )
                  : Container(),
            ],
          );
        }));
  }
}
