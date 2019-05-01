// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:async';

// class InnerWebview extends StatefulWidget {
//   // final GlobalKey<_WikipediaExplorerState> webKey;
//   final String url;

//   InnerWebview({this.url});

//   @override
//   _WikipediaExplorerState createState() => _WikipediaExplorerState();
// }

// class _WikipediaExplorerState extends State<InnerWebview> {
//   Completer<WebViewController> _controller = Completer<WebViewController>();
//   final Set<String> _favorites = Set<String>();
//   String _url;
//   final _key = UniqueKey();

//   @override
//   void initState() {
//     super.initState();

//     _url = widget.url;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Wikipedia Explorer'),
//         // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
//         actions: <Widget>[
//           // NavigationControls(_controller.future),
//           // Menu(_controller.future, () => _favorites),
//         ],
//       ),
//       body: WebView(
//         key: _key,
//         initialUrl: _url,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller.complete(webViewController);
//         },
//       ),
//       floatingActionButton: _bookmarkButton(),
//     );
//   }

//   _bookmarkButton() {
//     return FutureBuilder<WebViewController>(
//       future: _controller.future,
//       builder:
//           (BuildContext context, AsyncSnapshot<WebViewController> controller) {
//         if (controller.hasData) {
//           return FloatingActionButton(
//             onPressed: () async {
//               var url = await controller.data.currentUrl();
//               _favorites.add(url);
//               Scaffold.of(context).showSnackBar(
//                 SnackBar(content: Text('Saved $url for later reading.')),
//               );
//             },
//             child: Icon(Icons.favorite),
//           );
//         }
//         return Container();
//       },
//     );
//   }
// }