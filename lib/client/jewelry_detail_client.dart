import 'package:http/http.dart' as http;
import 'package:sayuga_jewels/constants/location_url.dart';

import 'package:sayuga_jewels/data/models/jewelry_details_model.dart';

class JewelryRequestFailure implements Exception {}

class JewelryDetailsNotFound implements Exception {}

class JewelryDetailsClient {
  final http.Client httpClient = http.Client();
  Future<JewelryDetailsModel> getJewelryDetails(int id) async {
    final request = Uri.https(
      LocationUrl.domain,
      '/jewelry/$id',
    );
    final response = await httpClient.get(request);
    if (response.statusCode == 404) {
      throw JewelryDetailsNotFound();
    }
    if (response.statusCode != 200) {
      throw JewelryRequestFailure();
    }
    return JewelryDetailsModel.fromJson(response.body);
  }
}
