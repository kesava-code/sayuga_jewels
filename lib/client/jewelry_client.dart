
import 'package:http/http.dart' as http;
import 'package:sayuga_jewels/constants/location_url.dart';
import 'package:sayuga_jewels/data/models/jewlery_list_model.dart';

class JewelryRequestFailure implements Exception {}

class JewelryNotFound implements Exception {}

class JewelryClient {
  
  final http.Client httpClient = http.Client();
  Future<JewelryList> getJewelry(Map<String, dynamic> queryParameters) async {
    final request = Uri.https(
      LocationUrl.domain,
      '/jewelry',
      queryParameters
    );
    final response = await httpClient.get(request);
    if (response.statusCode == 404) {
      throw JewelryNotFound();
    }
    if (response.statusCode != 200) {
      throw JewelryRequestFailure();
    }
    return JewelryList.fromJson(response.body);
  }
}
