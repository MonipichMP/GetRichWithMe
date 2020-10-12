import 'package:flutter/material.dart';
import 'package:get_rich_with_me/apis/exchange_rate_api.dart';
import 'package:get_rich_with_me/models/exchange_rate.dart';

class ExchangeRateProvider with ChangeNotifier {
  ExchangeRate dataExchangeRate = ExchangeRate(currencyFrom: "0.0", currencyTo: "0.0", rate: "0.0", lastRefreshed: "0:0");

  void getExChangeRateData(String currency) {
    var list = ExchangeRateAPI().getExchangeRate(currency);
    list.then((value) {
      dataExchangeRate = value;
      notifyListeners();
    });
  }

}
