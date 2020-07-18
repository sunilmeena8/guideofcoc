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
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Latest'),
          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        ),
        body: Builder(builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              WebView(
                initialUrl: 'https://en.wikipedia.org/wiki/Kraken',
                onPageFinished: (String url) {
                  print('Page started loading $url');
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
                        children: <Widget>[
                          Text(
                            'Please wait...',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontFamily: 'Quicksand'),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          );
        }));
  }
}
