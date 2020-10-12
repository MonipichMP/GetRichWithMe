import 'dart:convert';
import 'package:get_rich_with_me/constants/constants.dart';
import 'package:get_rich_with_me/models/exchange_rate.dart';
import 'package:http/http.dart' as http;

class ExchangeRateAPI {
  Future<ExchangeRate> getExchangeRate(String currency) async {
    var response = await http.get(
        "${Constants.URL_EXCHANGE_RATE}function=CURRENCY_EXCHANGE_RATE&"
        "from_currency=$currency&to_currency=USD&apikey=${Constants.API_KEY}");
    if (response.statusCode == 200) {
      print("get exchange rate success");
      print(response.body);
      var realTimeCurrency = jsonDecode(response.body);
      var data = realTimeCurrency['Realtime Currency Exchange Rate'];
      ExchangeRate exchangeRate = ExchangeRate.fromJson(data);
      return exchangeRate;
    } else {
      print("error: ${response.statusCode}, ${response.body}");
      return null;
    }
  }
}
