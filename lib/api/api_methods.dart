// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;

Future<double> getCoinPrice(String id) async {
  try {
    var url = Uri.parse(
        'https://api.coingecko.com/api/v3/simple/price?ids=$id&vs_currencies=usd&precision=4');
    var response = await http.get(url);
    var data = jsonDecode(response.body);
    return double.parse(data[id]['usd'].toString());
  } catch (e) {
    print(e.toString());
    return 0.0;
  }
}
