import 'package:http/http.dart' as http;
import 'package:sayuga_jewels/constants/location_url.dart';
import 'package:sayuga_jewels/data/models/filter_details.dart';

class ProductFilterDetailsRequestFailure implements Exception {}

class ProductFilterDetailsNotFound implements Exception {}

class ProductFilterDetailsClient {
  final http.Client httpClient = http.Client();
  Future<ProductFilterDetails> filterDetails() async {
    final request = Uri.https(
      LocationUrl.domain,
      '/filter-details',
    );
    final response = await httpClient.get(request);
    if (response.statusCode == 404) {
      throw ProductFilterDetailsNotFound();
    }
    if (response.statusCode != 200) {
      throw ProductFilterDetailsRequestFailure();
    }
    
    return ProductFilterDetails.fromJson(response.body);
  }
}
