import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getCoinPrice(String id) async {
  try {
    var url = Uri.parse('https://api.coingecko.com/api/v3/coins/$id');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    return double.parse(data['market_data']['current_price']['usd'].toString());
  } catch (e) {
    print(e.toString());
    return 0.0;
  }
}
