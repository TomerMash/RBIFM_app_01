import 'package:flutter/material.dart';
import 'package:reut_buy_it_for_me/app.dart';
import 'AppColors.dart';
import 'utils/connectionStatusSingleton.dart';
import 'package:reut_buy_it_for_me/tabs_demo_screen.dart';
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
      home: new TabsDemoScreen(),
    );
  }
}
