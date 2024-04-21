import 'package:http/http.dart' as http;
import 'package:sayuga_jewels/constants/location_url.dart';
import 'package:sayuga_jewels/data/models/best_of_sayuga_model.dart';

class RequestFailure implements Exception {}

class NotFound implements Exception {}

class NewForYouClient {
  final http.Client httpClient = http.Client();
  Future<JewelryList> getNewForYou() async {
    final request = Uri.https(LocationUrl.domain, '/new-for-you');
    final response = await httpClient.get(request);
    if (response.statusCode == 404) {
      throw NotFound();
    }
    if (response.statusCode != 200) {
      throw RequestFailure();
    }
    return JewelryList.fromJson(response.body);
  }
}
