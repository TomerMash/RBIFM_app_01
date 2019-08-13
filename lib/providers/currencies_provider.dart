import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:reut_buy_it_for_me/models/currencies_model.dart';
import 'package:flutter/scheduler.dart';

class CurrenciesProvider with ChangeNotifier {
  String _dataUrl = "https://api.exchangeratesapi.io/latest?base=";

  CurrenciesProvider() {
    print("CurrenciesProvider here");
    setBaseTextFieldControllerText('75');
    _baseTextFieldController.addListener(() {
      SchedulerBinding.instance.addPostFrameCallback((_) => updateTargetTextFieldControllerWithBaseText(_baseTextFieldController.text) );
      
    });
  }

  String _target = 'GBP';
  String _displayText = "";
  String _jsonResonse = "";
  bool _isFetching = false;
  final _baseTextFieldController = TextEditingController();
  final _targetTextFieldController = TextEditingController();

  TextEditingController get getBaseTextFieldController =>
      _baseTextFieldController;
  TextEditingController get getTargetTextFieldController =>
      _targetTextFieldController;

  void setBaseTextFieldControllerText(String text) {
    _baseTextFieldController.text = text;
    Currencies currencies = this.getResponseJson();
    if (currencies != null) {
      double baseAmount = double.tryParse(text);
      double targetRate = _getRate(_target);
      double targetAmount = baseAmount * targetRate;
      _targetTextFieldController.text = targetAmount.toStringAsFixed(4);
      notifyListeners();
    }
  }

  void updateTargetTextFieldControllerWithBaseText(String text) {
    Currencies currencies = this.getResponseJson();
    if (currencies != null) {
      double baseAmount = double.tryParse(text);
      double targetRate = _getRate(_target);
      double targetAmount = baseAmount * targetRate;
      _targetTextFieldController.text = targetAmount.toStringAsFixed(4);
      notifyListeners();
    }
  }

  double _getRate(String rate) {
    Currencies currencies = this.getResponseJson();
    if (currencies != null) {
      if (rate == 'USD') {
        return currencies.rates.usd;
      } else if (rate == 'EUR') {
        return currencies.rates.eur;
      } else if (rate == 'GBP') {
        return currencies.rates.gbp;
      } else if (rate == 'ILS') {
        return currencies.rates.ils;
      }
    }
    return 0;
  }

  void setTargetTextFieldControllerText(String text) {
    _targetTextFieldController.text = text;
    notifyListeners();
  }

  String get getTarget => _target;

  void setTarget(String target) {
    _target = target;
    SchedulerBinding.instance.addPostFrameCallback((_) => updateTargetTextFieldControllerWithBaseText(_baseTextFieldController.text) );
    notifyListeners();
  }

  void setDisplayText(String text) {
    _displayText = text;
    notifyListeners();
  }

  String get getDisplayText => _displayText;

  bool get isFetching => _isFetching;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _baseTextFieldController.dispose();
    _targetTextFieldController.dispose();
    super.dispose();
  }

  Future<void> fetchData({String base = 'USD', force = false}) async {
    if (_isFetching) {
      return;
    }

    if (_jsonResonse.length > 0 && !force) {
      return;
    }
    _isFetching = true;
    notifyListeners();

    String url = _dataUrl + base;
    print("currency url: " + url);
    Response response = await get(url);
    if (response.statusCode == 200) {
      _jsonResonse = response.body;
    }

    _isFetching = false;
    SchedulerBinding.instance.addPostFrameCallback((_) => updateTargetTextFieldControllerWithBaseText(_baseTextFieldController.text) );
    notifyListeners();
  }

  String get getResponseText => _jsonResonse;

  Currencies getResponseJson() {
    if (_jsonResonse.isNotEmpty) {
      Map<String, dynamic> json = jsonDecode(_jsonResonse);
      return Currencies.fromJson(json);
    }
    return null;
  }
}
