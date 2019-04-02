import 'package:flutter/material.dart';
import 'package:reut_buy_it_for_me/app.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Reut By It For My',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new App(),
    );
  }
}

