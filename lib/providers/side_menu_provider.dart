import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:package_info/package_info.dart';
import 'package:reut_buy_it_for_me/models/side_menu_model.dart';

class SideMenuProvider with ChangeNotifier {
  String _dataUrl = "https://reutbuyitforme.com/wp-json/wcra/v1/indexcategory/?secret_key=iPK2yFOSVY9DCkf5F6kQCBOQ2SfMsQcO&version=1.1.0";

  SideMenuProvider();

  String _displayText = "";
  String _jsonResonse = "";
  bool _isFetching = false;

  void setDisplayText(String text) {
    _displayText = text;
    notifyListeners();
  }

  String get getDisplayText => _displayText;

  bool get isFetching => _isFetching;

  Future<void> fetchData() async {
    if (_isFetching) {
      return;
    }

    if (_jsonResonse.length > 0) {
      return;
    }
    _isFetching = true;
    // notifyListeners();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;
    String url = _dataUrl;// + versionName;
    print("Menu: " + url);
    Response response = await get(url);
    if (response.statusCode == 200) {
      _jsonResonse = response.body;
    }

    _isFetching = false;
    notifyListeners();
  }

  String get getResponseText => _jsonResonse;

  List<SideMenuItem> getResponseJson() {
    if (_jsonResonse.isNotEmpty) {
      Map<String, dynamic> json = jsonDecode(_jsonResonse);
      Iterable list = json['data'];
      return list.map((item) => SideMenuItem.fromJson(item)).toList();
    }
    return new List<SideMenuItem>();
  }
}