import 'package:dio/dio.dart';
import 'package:trend/shared/core/shared_preferences.dart';
import 'package:trend/features/add_post/domain/entities/post.dart';

import '../../../../shared/const/app_links.dart';

class Addnewpostrepo {
  Dio dio = Dio();

  Future<void> uploadPost({required NewPost post}) async {
    try {
      String? t = await token.getToken();
      Response response = await dio.post(
        ApiEndpoints.addPost,
        data: FormData.fromMap({
          'image': await MultipartFile.fromFile(
            post.fileImage.path,
            filename: post.fileImage.path.split('/').last,
          ),
          'description': post.description,
        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer ${t}',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      print('Image uploaded successfully!');
      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
        print('Response data: ${response.data}');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading: $e');
    }
  }
}
