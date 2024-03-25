import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadService {
  Future<void> uploadImage(XFile? pickedFile) async {
    try {
      Dio dio = Dio();

      if (pickedFile != null) {
        FormData formData = FormData.fromMap({

          // userFile is the name of json "key"(userFile) : ""
          'userFile': await MultipartFile.fromFile(pickedFile.path, filename: 'image.jpg'),
        });

        Response response = await dio.post(
          '',
          data: formData,
        );

        if (response.statusCode == 200) {
          if (kDebugMode) {
            print("Image uploaded successfully");
          }
        } else {
          // handle file
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error uploading image: $error');
      }
    }
  }
}