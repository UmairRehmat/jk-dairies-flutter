import 'dart:convert';

import 'package:jkdairies/models/districts_response.dart';
import 'package:jkdairies/utils/network_collection.dart';
import 'package:http/http.dart' as http;

class DistrictProvider {
  Future<List<Cities>> getDistricts() async {
    try {
      Uri url = Uri.parse("$BASE_URL$citiesEndPoint");
      var response = await http.get(url);
      print('districts Response status: ${response.statusCode}');
      print('districts Response body: ${response.body}');
      CitiesResponse citiesResponse =
          CitiesResponse.fromJson(json.decode(response.body));
      return citiesResponse.cities;
    } catch (error) {
      return [];
    }
  }
}
