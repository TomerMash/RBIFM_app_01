
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'AppColors.dart';

class TabWebView extends StatelessWidget {
  TabWebView({this.title, this.url});
  final String title;
  final String url;

  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Flutter WebView example'),
  //     ),
  //     body: Builder(builder: (BuildContext context) {
  //       return WebView(
  //         initialUrl: 'assets/threejs.html',
  //         javascriptMode: JavascriptMode.unrestricted,
  //         onWebViewCreated: (WebViewController webViewController) {
  //           _controller.complete(webViewController);
  //         },
  //       );
  //     }),
  //     floatingActionButton: favoriteButton(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
            backgroundColor: AppColors.pink,
        ),
        body: Container(
          color: Colors.white,
          child: _buildWebView(),
        ));
  }

  Widget _buildWebView() {
    return new WebviewScaffold(
            url: url,
            hidden: true,
            initialChild: Container(
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
  }
}