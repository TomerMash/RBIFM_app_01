import 'package:flutter/material.dart';
import 'package:reut_buy_it_for_me/bottom_navigation.dart';
// import 'package:reut_buy_it_for_me/tab_navigator.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import './notifications/push_popup.dart';
import 'package:reut_buy_it_for_me/onboarding/onboarding_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/connectionStatusSingleton.dart';
import 'dart:async';
import 'package:reut_buy_it_for_me/notifications/notification_model.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  StreamSubscription _connectionChangeStream;
  bool isOffline = false;
  TabItem currentTab = TabItem.home;
  int _currentIndex = 0;
  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.favorites: GlobalKey<NavigatorState>(),
    TabItem.buyMe: GlobalKey<NavigatorState>(),
    TabItem.meetUs: GlobalKey<NavigatorState>(),
    TabItem.calculator: GlobalKey<NavigatorState>(),
  };
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseCloudMessagingListeners();
    _initConnectionListener();
    _shouldShowWelcome();
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
        NotificationObject notification = new NotificationObject.fromJson(message);
        print('on message $message');
        presentPushNotification(context, notification);
      },
      // When your app is in the background and you get a notification your app will be brought to the front and the onResume: will be the entry point into your application
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        NotificationObject notification = new NotificationObject.fromJson(message);
        presentPushNotification(context, notification);
      },
      // When your app is not active and you get a notification
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        NotificationObject notification = new NotificationObject.fromJson(message);
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

  void _selectTab(TabItem tabItem) {
    setState(() {
      currentTab = tabItem;
    });
  }

  void _selectedIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
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
      setState(() {
        currentTab = TabItem.favorites;
      });
    } else if (result == "calculator") {
      setState(() {
        currentTab = TabItem.calculator;
      });
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[currentTab].currentState.maybePop(),
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.home),
          _buildOffstageNavigator(TabItem.favorites),
          _buildOffstageNavigator(TabItem.buyMe),
          _buildOffstageNavigator(TabItem.meetUs),
          _buildOffstageNavigator(TabItem.calculator),
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: currentTab,
          onSelectTab: _selectTab,
          onTabIndex: _selectedIndex,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: currentTab != tabItem,
      // child: TabNavigator(
      //   navigatorKey: navigatorKeys[tabItem],
      //   tabItem: tabItem,
      // ),
    );
  }
}
