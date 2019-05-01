// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'dart:async';

// import './utils/AppColors.dart';

// // String url = 'https://google.com';

// class TabWebView extends StatelessWidget {
//   TabWebView({this.title, this.url});
//   final String title;
//   final String url;

//   // final Completer<WebViewController> _controller =
//   //     Completer<WebViewController>();

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: const Text('Flutter WebView example'),
//   //     ),
//   //     body: Builder(builder: (BuildContext context) {
//   //       return WebView(
//   //         initialUrl: 'assets/threejs.html',
//   //         javascriptMode: JavascriptMode.unrestricted,
//   //         onWebViewCreated: (WebViewController webViewController) {
//   //           _controller.complete(webViewController);
//   //         },
//   //       );
//   //     }),
//   //     floatingActionButton: favoriteButton(),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             title,
//           ),
//           backgroundColor: AppColors.pink,
//         ),
//         body: Container(
//           color: Colors.white,
//           child: _buildWebView(),
//         ));
//   }

//   Widget _buildWebView() {
//     return new WebviewScaffold(
//       url: url,
//       hidden: true,
//       initialChild: Container(
//         child: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }
// // ----- End of stateless

// class RTWebView extends StatefulWidget {
//   final String title;
//   final String url;

//   RTWebView(this.title, this.url);

//   @override
//   State<RTWebView> createState() => _WebViewState();
// }

// class _WebViewState extends State<RTWebView> {
// // Instance of WebView plugin
//   final flutterWebviewPlugin = new FlutterWebviewPlugin();

//   // On destroy stream
//   StreamSubscription _onDestroy;

//   // On urlChanged stream
//   StreamSubscription<String> _onUrlChanged;

//   // On urlChanged stream
//   StreamSubscription<WebViewStateChanged> _onStateChanged;

//   StreamSubscription<WebViewHttpError> _onHttpError;

//   final _history = [];

//   final _scaffoldKey = new GlobalKey<ScaffoldState>();

//   String _title;
//   String _url;

//   @override
//   void initState() {
//     super.initState();

//     _url = widget.url;
//     _title = widget.title;

//     flutterWebviewPlugin.close();

//     // Add a listener to on destroy WebView, so you can make came actions.
//     _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
//       if (mounted) {
//         // Actions like show a info toast.
//         _scaffoldKey.currentState.showSnackBar(
//             const SnackBar(content: const Text('Webview Destroyed')));
//       }
//     });

//     // Add a listener to on url changed
//     _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
//       if (mounted) {
//         setState(() {
//           if (_url != url) {
//             flutterWebviewPlugin.hide();
//           }
//           _history.add('onUrlChanged: $url');
//         });
//       }
//     });

//     _onStateChanged =
//         flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
//           print(state.type);
//       if (mounted) {
//         setState(() {
//           _history.add('onStateChanged: ${state.type} ${state.url}');
//         });
//       }
//     });

//     _onHttpError =
//         flutterWebviewPlugin.onHttpError.listen((WebViewHttpError error) {
//       if (mounted) {
//         setState(() {
//           _history.add('onHttpError: ${error.code} ${error.url}');
//         });
//       }
//     });
//     flutterWebviewPlugin.reloadUrl(_url);
//   }

//   @override
//   void dispose() {
//     // Every listener should be canceled, the same should be done with this stream.
//     _onDestroy.cancel();
//     _onUrlChanged.cancel();
//     _onStateChanged.cancel();
//     _onHttpError.cancel();

//     flutterWebviewPlugin.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
        
//         body: Container(
//           color: Colors.white,
//           child: _buildWebView(),
//         ));
//   }

//   Widget _buildWebView() {
//     return new WebviewScaffold(
//       url: _url,
//       hidden: true,
//       withZoom: false,
//       initialChild: Container(
//         child: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     );
//   }
// }
