import 'package:flutter/material.dart';
import 'pages/main_app.dart';
import './utils/AppColors.dart';
import 'utils/connectionStatusSingleton.dart';

void main() {
  ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Reut By It For My',
      theme: ThemeData(
        primarySwatch: AppColors.pink,
      ),
      home: new MainApp(),
    );
  }
}
