import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:bookbytes/models/user.dart';
import 'package:bookbytes/shared/myserverconfig.dart';

class BillScreen extends StatefulWidget {
  final User user;
  final double totalprice;

  const BillScreen({Key? key, required this.user, required this.totalprice})
      : super(key: key);

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {

    final initialUrl =
        '${MyServerConfig.server}/bookbytes/php/payment.html?userid=${widget.user.userid}&email=${widget.user.useremail}&name=${widget.user.username}&amount=${widget.totalprice}';

    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          controller = webViewController;
        },

        gestureRecognizers: Set()
          ..add(Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())),
      ),
    );




  }
}
