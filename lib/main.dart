import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reut_buy_it_for_me/providers/currencies_provider.dart';
import 'package:reut_buy_it_for_me/providers/side_menu_provider.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Reut By It For My',
        theme: ThemeData(
          primarySwatch: AppColors.pink,
        ),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<SideMenuProvider>(
              builder: (_) => SideMenuProvider(),
            ),
            ChangeNotifierProvider<CurrenciesProvider>(
              builder: (_) => CurrenciesProvider(),
            ),
          ],
          child: MainApp(),
        ));
  }
}
