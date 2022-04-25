import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient{
  final Uri cryptoURL = Uri.https("api.coingecko.com", "api/v3/exchange_rates");

Future<List<String>> getExchangeRates() async{
  http.Response res = await http.get(cryptoURL);
  if(res.statusCode == 200){
    var body = jsonDecode(res.body);
    var list = body["rates"];
    // ignore: unused_local_variable
    List<String> crypto = (list.keys).toList();
    // ignore: avoid_print
    print (crypto);
    return crypto;
  }else{
    throw Exception("Failed to connect to API");
  }
}
}