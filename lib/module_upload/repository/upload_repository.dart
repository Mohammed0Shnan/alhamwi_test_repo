
import 'package:alhamwi_test/consts/urls.dart';
import 'package:alhamwi_test/module_upload/response/imagebb_response.dart';
import 'package:alhamwi_test/utils/logger/logger.dart';
import 'package:dio/dio.dart';

class UploadRepository {


    Future<ImgBBResponse?> upload(String filePath) async {
    var client = Dio();
    FormData data = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath),
    });

    Logger().info('UploadRepo', 'Uploading: ' + filePath);
    Response response = await client.post(
      Urls.BASE_URL,
      data: data,
    );
    Logger().info('Got a Response', response.toString());

    if (response == null) {
      return null;
    }
    print('urllllllllllllllllllllllllllllll');
    print(response.data);
     return ImgBBResponse(url: response.data);
  }
}
