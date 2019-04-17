import 'package:flutter/material.dart';
import 'package:reut_buy_it_for_me/app.dart';
import 'package:reut_buy_it_for_me/home_widget.dart';
import 'package:reut_buy_it_for_me/onboarding/onboarding_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppColors.dart';
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
      home: _getScreen(),
    );
  }

  _getScreen() {
    int result = 1; //_read();
    if (result == 1) {
      return new App();
    }
    _save();
    return OnboardingMainPage();
  }

  _read() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'welcome';
    final value = prefs.getInt(key) ?? 0;
    print('read: $value');
    return value;
  }

  _save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'welcome';
    final value = 1;
    prefs.setInt(key, value);
    print('saved $value');
  }
}
