import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:jkdairies/models/CategoryModel.dart';
import 'package:jkdairies/utils/network_collection.dart';
import 'package:http/http.dart' as http;

class ProductsProvider extends ChangeNotifier {
  List<Data> products = [];
  int selectedIndex = 0;

  Future<CategoryModel> getProducts() async {
    try {
      Uri url = Uri.parse("$BASE_URL$categoryEndPoint");
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      CategoryModel categoryModel =
          CategoryModel.fromJson(json.decode(response.body));
      products = categoryModel.data;
      return categoryModel;
    } catch (error) {
      return CategoryModel.withError();
    }
  }
}
