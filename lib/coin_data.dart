import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const api_key = '5C008732-4586-4621-9A81-8DFDE913A0F4';

class CurrencyDetail {
  Future getCurrencyData(String currency) async {
    Map<String, String> CoinValues = {};

    for (String crypto in cryptoList) {
      http.Response response = await http.get((Uri.parse(
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$api_key')));

      if (response.statusCode == 200) {
        String data = response.body;
        // print(data);
        dynamic currData = await jsonDecode(data);
        double c = currData['rate'];
        CoinValues[crypto] = c.toStringAsFixed(0);
      } else {
        print(response.statusCode);
      }
    }

    return CoinValues;
  }
}
