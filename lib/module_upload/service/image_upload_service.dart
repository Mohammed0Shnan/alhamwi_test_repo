import 'package:alhamwi_test/module_upload/enum/image_type.dart';
import 'package:alhamwi_test/module_upload/repository/upload_repository.dart';
import 'package:alhamwi_test/module_upload/response/imagebb_response.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_windows/image_picker_windows.dart';

class ImageUploadService {
  final UploadRepository _uploadRepository = UploadRepository();

  Future<String?> uploadImage(String filePath ,ImageType imageType) async {

    try {

      /// This Section

      String fileName = '';
      if(imageType == ImageType.PRODUCT){
        fileName = 'products/';
      }
    ImgBBResponse? response = await _uploadRepository.upload(filePath);
    if (response == null) {
      return null;
    } else {
      return response.url;
    }
    } catch (e) {
      print('error in uploading image for : ${e.toString()}');
      return null;
    }


  }
  

  Future<String> getImageFromGallery(ImageSource  imageSource) async {
    String? _path;
    try {
      var pickedImage = await ImagePickerWindows().pickImage(source: imageSource);
      _path = pickedImage!.path;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    String file = _path != null ? _path : '';
    return file; //await cropImage(file);
  }

}
