import 'dart:convert';

import 'package:jkdairies/utils/network_collection.dart';
import 'package:http/http.dart' as http;

class CheckoutProvider {
  Future<bool> placeOrder(Map apiData) async {
    try {
      Uri url = Uri.parse("$BASE_URL$orderPlaceEndPoint");
      print("URL log$url");
      var response = await http.post(url, body: jsonEncode(apiData));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.statusCode == 200 ? true : false;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
