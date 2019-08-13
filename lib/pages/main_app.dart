import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:reut_buy_it_for_me/bottom_navigation.dart';
import 'package:reut_buy_it_for_me/models/side_menu_model.dart';
import 'package:reut_buy_it_for_me/notifications/notification_model.dart';
import 'package:reut_buy_it_for_me/onboarding/onboarding_controller.dart';
import 'package:reut_buy_it_for_me/pages/calculator_page.dart';
import 'package:reut_buy_it_for_me/providers/currencies_provider.dart';
import 'package:reut_buy_it_for_me/providers/side_menu_provider.dart';
import 'package:reut_buy_it_for_me/widgets/side_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../notifications/push_popup.dart';
import '../utils/AppColors.dart';
import '../utils/connectionStatusSingleton.dart';

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<MainApp> {
  SideMenuItem _selectedDrawerItem = SideMenuItem(
      name: 'רעות תקני לי',
      type: 'url',
      action: TabHelper.url(TabItem.home),
      menuOrder: 0);
  StreamSubscription _connectionChangeStream;
  bool isOffline = false;
  InAppWebViewController webView;
  String url = TabHelper.url(TabItem.home);
  double progress = 0;
  ProgressHUD _progressHUD;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseCloudMessagingListeners();
    _initConnectionListener();
    _initProgressHUD();
    _shouldShowWelcome();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      setState(() {
        _fetchMenuData();
        _fetchCurrenciesData();
      });
    });
  }

  void _initProgressHUD() {
    _progressHUD = new ProgressHUD(
      backgroundColor: Colors.black12,
      color: Colors.white,
      containerColor: AppColors.pink,
      borderRadius: 8.0,
      text: '...טוען',
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _initConnectionListener() {
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
    connectionStatus.isConnectedToInternet().then((isConnected) {
      if (!isConnected) {
        _showAlert(context);
      }
    });
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
    print(isOffline);
    if (isOffline) {
      _showAlert(context);
    }
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Info"),
              content: Text(
                  "Internet not available, Please check your internet connectivity and try again"),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  void _firebaseCloudMessagingListeners() {
    if (Platform.isIOS) _iosPermission();

    _firebaseMessaging.getToken().then((token) {
      print('token: $token');
    });

    _firebaseMessaging.configure(
      // When you get a notification and your app is active, then you just want to receive the message. For this the onMessage: will be the entry point into your application.
      onMessage: (Map<String, dynamic> message) async {
        NotificationObject notification =
            new NotificationObject.fromJson(message);
        print('on message $message');
        presentPushNotification(context, notification);
      },
      // When your app is in the background and you get a notification your app will be brought to the front and the onResume: will be the entry point into your application
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        NotificationObject notification =
            new NotificationObject.fromJson(message);
        presentPushNotification(context, notification);
      },
      // When your app is not active and you get a notification
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        NotificationObject notification =
            new NotificationObject.fromJson(message);
        presentPushNotification(context, notification);
      },
    );
  }

  void _iosPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  _fetchMenuData() {
    final data = Provider.of<SideMenuProvider>(context);
    data.fetchData();
  }

  _fetchCurrenciesData() {
    final data = Provider.of<CurrenciesProvider>(context);
    data.fetchData();
  }

  _shouldShowWelcome() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'welcome';
    final value = prefs.getInt(key) ?? 0;
    if (value == 1) {
      return;
    }
    _saveWelcomeShowed();
    final result = await Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true, builder: (context) => OnboardingMainPage()));
    if (result == "favorite") {
      url = TabHelper.url(TabItem.favorites);
      webView.loadUrl(url);
    } else if (result == "calculator") {
      url = TabHelper.url(TabItem.calculator);
      webView.loadUrl(url);
    }
  }

  _saveWelcomeShowed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'welcome';
    final value = 1;
    prefs.setInt(key, value);
    print('saved $value');
  }

  Future presentPushNotification(context, NotificationObject message) async {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => PushPopup()));
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true, builder: (context) => PushPopup(message)));
    // navigatorKeys[currentTab].currentState.push(MaterialPageRoute(
    //     fullscreenDialog: true, builder: (context) => PushPopup(message)));
  }

  _getDrawerItemWidget(SideMenuItem item) {
    if (item.type.toLowerCase() == 'url') {
      if (webView != null) {
        if (item.action != this.url) {
          webView.loadUrl(item.action);
          return _getWebviewBody();
        }
      }
    } else if (item.type.toLowerCase() == 'calculator') {
      return new CalculatorFragment();
    }
    // return new Text("Error");
    return _getWebviewBody();
  }

  Widget _getWebviewBody() {
    return new Stack(children: <Widget>[
      InAppWebView(
        initialUrl: _selectedDrawerItem.action,
        initialHeaders: {},
        initialOptions: {},
        onWebViewCreated: (InAppWebViewController controller) {
          webView = controller;
        },
        onLoadStart: (InAppWebViewController controller, String url) {
          print("started $url");
          setState(() {
            this.url = url;
            _progressHUD.state.show();
          });
        },
        onLoadStop: (InAppWebViewController controller, String url) {
          print("Stopped $url");
          setState(() {
            _progressHUD.state.dismiss();
          });
        },
        onProgressChanged: (InAppWebViewController controller, int progress) {
          setState(() {
            this.progress = progress / 100;
          });
        },
      ),
      _progressHUD
    ]);
  }

  void _updatePageFromDrwaer(SideMenuItem item) {
    setState(() => _selectedDrawerItem = item);
    Navigator.of(context).pop();
    // _getDrawerItemWidget(item);
    // if (item.type.toLowerCase() == 'url') {
    //   webView.loadUrl(item.action);
    // } else if (item.type == 'calculator') {
    //   // Do something
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: new SideDrawer(_updatePageFromDrwaer),
        // endDrawer: Theme(
        //   data: Theme.of(context)
        //       .copyWith(canvasColor: Color.fromRGBO(244, 244, 244, 1)),
        //   child: Drawer(
        //     child: Padding(
        //       padding: const EdgeInsets.fromLTRB(16, 60, 24, 16),
        //       child: Column(
        //         children: <Widget>[

        //           // ListTile(
        //           //   title: Align(
        //           //     alignment: Alignment.centerRight,
        //           //     child: Text(
        //           //       TabHelper.description(TabItem.home),
        //           //       style: Theme.of(context).textTheme.title.copyWith(
        //           //           color: AppColors.menuText,
        //           //           fontWeight: FontWeight.bold),
        //           //     ),
        //           //   ),
        //           //   onTap: () {
        //           //     url = TabHelper.url(TabItem.home);
        //           //     webView.loadUrl(url);
        //           //     Navigator.pop(context);
        //           //   },
        //           // ),
        //           // ListTile(
        //           //   title: Align(
        //           //     alignment: Alignment.centerRight,
        //           //     child: Text(
        //           //       TabHelper.description(TabItem.favorites),
        //           //       style: Theme.of(context).textTheme.title.copyWith(
        //           //           color: AppColors.menuText,
        //           //           fontWeight: FontWeight.bold),
        //           //     ),
        //           //   ),
        //           //   onTap: () {
        //           //     url = TabHelper.url(TabItem.favorites);
        //           //     webView.loadUrl(url);
        //           //     Navigator.pop(context);
        //           //   },
        //           // ),
        //           // ListTile(
        //           //   title: Align(
        //           //     alignment: Alignment.centerRight,
        //           //     child: Text(
        //           //       TabHelper.description(TabItem.buyMe),
        //           //       style: Theme.of(context).textTheme.title.copyWith(
        //           //           color: AppColors.menuText,
        //           //           fontWeight: FontWeight.bold),
        //           //     ),
        //           //   ),
        //           //   onTap: () {
        //           //     url = TabHelper.url(TabItem.buyMe);
        //           //     webView.loadUrl(url);
        //           //     Navigator.pop(context);
        //           //   },
        //           // ),
        //           // ListTile(
        //           //   title: Align(
        //           //     alignment: Alignment.centerRight,
        //           //     child: Text(
        //           //       TabHelper.description(TabItem.meetUs),
        //           //       style: Theme.of(context).textTheme.title.copyWith(
        //           //           color: AppColors.menuText,
        //           //           fontWeight: FontWeight.bold),
        //           //     ),
        //           //   ),
        //           //   onTap: () {
        //           //     url = TabHelper.url(TabItem.meetUs);
        //           //     webView.loadUrl(url);
        //           //     Navigator.pop(context);
        //           //   },
        //           // ),
        //           // ListTile(
        //           //   title: Align(
        //           //     alignment: Alignment.centerRight,
        //           //     child: Text(
        //           //       TabHelper.description(TabItem.calculator),
        //           //       style: Theme.of(context).textTheme.title.copyWith(
        //           //           color: AppColors.menuText,
        //           //           fontWeight: FontWeight.bold),
        //           //     ),
        //           //   ),
        //           //   onTap: () {
        //           //     url = TabHelper.url(TabItem.calculator);
        //           //     webView.loadUrl(url);
        //           //     Navigator.pop(context);
        //           //   },
        //           // ),
        //           // ListTile(
        //           //   title: Align(
        //           //     alignment: Alignment.centerRight,
        //           //     child: Text(
        //           //       "דרג/י אותנו",
        //           //       style: Theme.of(context).textTheme.title.copyWith(
        //           //           color: AppColors.pink, fontWeight: FontWeight.bold),
        //           //     ),
        //           //   ),
        //           //   onTap: () {
        //           //     LaunchReview.launch(
        //           //         writeReview: false,
        //           //         androidAppId: "com.reuttomer.reut_buy_it_for_me",
        //           //         iOSAppId: "1460171905");
        //           //     Navigator.pop(context);
        //           //   },
        //           // ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        appBar: AppBar(
          brightness: Brightness.dark,
          title: Text(_selectedDrawerItem.name),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(
              title: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          )),
        ),
        body: _getDrawerItemWidget(_selectedDrawerItem));
  }
}
