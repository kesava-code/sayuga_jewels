import 'package:http/http.dart' as http;
import 'package:sayuga_jewels/constants/location_url.dart';
import 'package:sayuga_jewels/data/models/banner_data.dart';

class RequestFailure implements Exception {}

class NotFound implements Exception {}

class BannerClient {
  final http.Client httpClient = http.Client();
  Future<BannerData> getBanner() async {
    final request = Uri.https(LocationUrl.domain, '/banner');
    final response = await httpClient.get(request);
    if (response.statusCode == 404) {
      throw NotFound();
    }
    if (response.statusCode != 200) {
      throw RequestFailure();
    }
    return BannerData.fromJson(response.body);
  }
}
