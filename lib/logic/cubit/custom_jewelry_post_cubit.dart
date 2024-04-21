
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sayuga_jewels/constants/location_url.dart';

part 'custom_jewelry_post_state.dart';

class CustomJewelryPostCubit extends Cubit<CustomJewelryPostState> {
  CustomJewelryPostCubit() : super(CustomJewelryPostInitial());
  void newForm() {
    emit(CustomJewelryPostInitial());
  }

  void uploadFile({
    required XFile file,
    required String email,
    required String mobile,
    required String description,
  }) async {
    emit(CustomJewelryPostUploading());

    // Uint8List imageList = await file.readAsBytes();
    // var stream = http.ByteStream.fromBytes(imageList);
    // stream.cast();

    // int length = await file.length();
    Uri uri = Uri.http(LocationUrl.domain, '/custom-design');
    http.MultipartRequest multipartRequest = http.MultipartRequest('POST', uri);

    Map<String, String> body = {
      "mobile": mobile,
      "description": description,
      "email": email,
    };

    http.MultipartFile multipartFile = http.MultipartFile(
        'design', file.readAsBytes().asStream(), await file.length(),
        filename: file.name.split('/').last,
        contentType: MediaType('application', 'json'));

    multipartRequest.headers.addAll(
        {'content-type': 'application/json', 'accept': 'application/json'});
    multipartRequest.fields.addAll(body);

    multipartRequest.files.add(multipartFile);

    var response = await multipartRequest.send();
    // final contents = StringBuffer();
    // await for (var data in response.stream.transform(utf8.decoder)) {
    //   contents.write(data);
    // }

    if (response.statusCode == 201) {
      emit(CustomJewelryPostUploaded());
      return;
    }

    emit(CustomJewelryPostFailure());
  }
}
