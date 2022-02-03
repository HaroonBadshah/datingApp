import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: WillPopScope(
          onWillPop: () async {
            return _onBackPressed();
            
          },
          child: Container(
            // height: MediaQuery.of(context).size.height * 1,
            child: WebView(
              initialUrl:
                  "http://jacmich.cyou?utm_source=jacmich_aosapp&device_id={android_id}&push-token={player_id}&kd_id={kd_id}&ref={ref}&gaid={gaid}",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
          ),
        ),
      ),
    );
  }

  // /
  // /on[ backpressed] call back to avoid user interaction with splash screen
  // /
  Future<bool> _onBackPressed() async {
    return await Get.defaultDialog(
          title: 'Are you sure?',
          content: Text('Do you want to exit an App'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                "No",
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                exit(0);
              },
              child: Text(
                "Yes",
              ),
            ),
          ],
        ) ??
        false;
  }
}
