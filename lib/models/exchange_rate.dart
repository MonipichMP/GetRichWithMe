class ExchangeRate {
  String currencyFrom;
  String currencyTo;
  String rate;
  String lastRefreshed;

  ExchangeRate({
    this.currencyFrom,
    this.currencyTo,
    this.rate,
    this.lastRefreshed,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json){
    return ExchangeRate(
      currencyFrom: json['2. From_Currency Name'],
      currencyTo: json['4. To_Currency Name'],
      rate: json['5. Exchange Rate'],
      lastRefreshed: json['6. Last Refreshed']
    );
  }
}
