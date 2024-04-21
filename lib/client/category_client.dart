import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sayuga_jewels/constants/location_url.dart';
import 'package:sayuga_jewels/data/models/category_model.dart';

class RequestFailure implements Exception {}

class NotFound implements Exception {}

class CategoryClient {
  final http.Client httpClient = http.Client();
  Future<List<JewelryCategory>> getCategories() async {
    final request = Uri.https(LocationUrl.domain, '/categories');
    final response = await httpClient.get(request);
    if (response.statusCode == 404) {
      throw NotFound();
    }
    if (response.statusCode != 200) {
      throw RequestFailure();
    }
    List<dynamic> categoriesList = json.decode(response.body);
    return categoriesList.map((e) => JewelryCategory.fromMap(e)).toList();
  }
}
