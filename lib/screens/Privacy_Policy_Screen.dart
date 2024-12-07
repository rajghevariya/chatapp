import 'package:demochats/Components/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Privacy_policy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: const WebView(
          initialUrl:
              'https://www.privacypolicies.com/live/75720f41-5a54-4039-b80e-dce12374062b',
          backgroundColor: bgcolor,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
