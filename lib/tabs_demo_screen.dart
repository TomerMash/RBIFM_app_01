import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'push_popup.dart';
import 'package:reut_buy_it_for_me/onboarding/onboarding_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/connectionStatusSingleton.dart';
import 'dart:async';
import 'package:reut_buy_it_for_me/notifications/notification_model.dart';
import 'bottom_navigation.dart';
import 'tab_screen.dart';
import 'tab_home.dart';
import 'tab_meetus.dart';
import 'tab_calculator.dart';
import 'tab_buy_it_for_me.dart';
import 'tab_favorite.dart';
import 'tab_webview.dart';
import 'webview_test.dart';

class TabsDemoScreen extends StatefulWidget {
  TabsDemoScreen() : super();

  @override
  _TabsDemoScreenState createState() => _TabsDemoScreenState();
}

class _TabsDemoScreenState extends State<TabsDemoScreen> {
  static final String title = "רעות תקני לי";
  int currentTabIndex = 0;
  List<Widget> tabs = [
    InnerWebview(url: TabHelper.url(TabItem.home)),
    InnerWebview(url: TabHelper.url(TabItem.favorites)),
    TabBuyItForMe(title, TabHelper.url(TabItem.buyMe)),
    TabMeetUs(title, TabHelper.url(TabItem.meetUs)),
    TabCalculator(title, TabHelper.url(TabItem.calculator))
  ];
  StreamSubscription _connectionChangeStream;
  bool isOffline = false;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

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
        print('on message $message');
        presentPushNotification(context, message);
      },
      // When your app is in the background and you get a notification your app will be brought to the front and the onResume: will be the entry point into your application
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        presentPushNotification(context, message);
      },
      // When your app is not active and you get a notification
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        presentPushNotification(context, message);
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
        currentTabIndex = 1;
      });
    } else if (result == "calculator") {
      setState(() {
        currentTabIndex = 4;
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

  Future presentPushNotification(context, Map<String, dynamic> message) async {
    print("Message: $message");
    NotificationObject notification = new NotificationObject.fromJson(message);//
    if (Platform.isIOS) {
      String title = message["apn"]["alert"]["title"];  
      print("Title: $title");
    }
    
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PushPopup(notification)));
    // Navigator.of(context).push(MaterialPageRoute(
    //     fullscreenDialog: true, builder: (context) => PushPopup(message)));
    // navigatorKeys[currentTab].currentState.push(MaterialPageRoute(
    //     fullscreenDialog: true, builder: (context) => PushPopup(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        
      ),
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTapped,
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(tabItem: TabItem.home),
          _buildItem(tabItem: TabItem.favorites),
          _buildItem(tabItem: TabItem.buyMe),
          _buildItem(tabItem: TabItem.meetUs),
          _buildItem(tabItem: TabItem.calculator)
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String text = TabHelper.description(tabItem);
    AssetImage icon = TabHelper.icon(tabItem);
    return BottomNavigationBarItem(
      icon:
          new ImageIcon(icon, color: _colorTabMatching(item: tabItem)), //Icon(
//        icon,
//        color: _colorTabMatching(item: tabItem),
//      ),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(item: tabItem),
        ),
      ),
    );
  }

  Color _colorTabMatching({TabItem item}) {
    return currentTabIndex == item.index ? TabHelper.color(item) : Colors.grey;
  }
}
