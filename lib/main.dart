import 'package:flutter/material.dart';
import 'pages/main_app.dart';
import './utils/AppColors.dart';
import 'utils/connectionStatusSingleton.dart';
// import 'package:flutter/services.dart';

void main() {
  _customInit();
  _initUI();
  runApp(new MyApp());
}

void _initUI() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: AppColors.pink, // navigation bar color
  //   statusBarColor: Colors.white, // status bar color
  // ));
}

void _customInit() {
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reut By It For My',
      theme: ThemeData(
        primarySwatch: AppColors.pink,
      ),
      home: new MainApp(),
    );
  }
}
