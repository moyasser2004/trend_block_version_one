import 'package:dio/dio.dart';
import 'package:trend/shared/core/shared_preferences.dart';
import 'package:trend/features/posts/data/models/post_model.dart';
import 'package:trend/features/profile/domain/repositories/profile_repository.dart';

import '../../../../shared/const/app_links.dart';

class DataRemoteSource {
  Dio dio;
  DataRemoteSource(this.dio);
  Future<List<PostModel>> getPostForspecificUserMethod(int id) async {
    try {
      String? tok = await token.getToken();
      final response = await dio.get(
        "http://167.71.92.176/posts/${id}/posts/",
        options: Options(
          headers: {'Authorization': 'Bearer $tok'},
        ),
      );

      var data = response.data["results"];
      List<PostModel> posts = [];
      for (var element in data) {
        posts.add(PostModel.fromJson(element));
      }
      return posts;
    } catch (e) {
      List<PostModel> posts = [];
      return posts;
    }
  }

  Future<List<PostModel>> fetchPosts() async {
    try {
      String url = ApiEndpoints.Nextpage ?? "";
      if (url.length == 0) {
        url = 'http://167.71.92.176/posts/all-posts/';
      }
      print("================================================");
      print(url);

      print("================================================");
      String? tok = await token.getToken();
      print(url);
      final response = await dio.get(
        url,
        options: Options(headers: {'Authorization': 'Bearer $tok'}),
      );

      if (response.statusCode == 200) {
        ApiEndpoints.setnext(response.data["next"] ?? "");
        final data = response.data as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>;

        return results.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch posts');
      }
    } catch (e) {
      throw Exception('Error fetching posts: $e');
    }
  }

  Future<Comment?> commentComment(
      {required int postId,
      required int commentId,
      required String comment}) async {
    try {
      String? tok = await token.getToken();
      Response response = await dio.post(
          "http://167.71.92.176/posts/comments/$commentId/reply/",
          data: {"post": postId, "content": comment},
          options: Options(headers: {'Authorization': 'Bearer $tok'}));
      if ((response.statusCode ?? 400) < 300) {
        return Comment.fromJson(response.data);
      } else {
        throw Failure(message: response.data.toString());
      }
    } on Exception catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future<Comment?> commentPost(int id, String comment) async {
    try {
      String? tok = await token.getToken();
      Response response = await dio.post(
          "http://167.71.92.176/posts/$id/comments/",
          data: {"post": id, "content": comment},
          options: Options(headers: {'Authorization': 'Bearer $tok'}));
      if ((response.statusCode ?? 400) < 300) {
        return Comment.fromJson(response.data);
      } else {
        throw Failure(message: response.data.toString());
      }
    } on Exception catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future<bool?> deleteComment(int id, int commentId) async {
    try {
      String? tok = await token.getToken();
      Response response = await dio.delete(
          "http://167.71.92.176/posts/$id/comments/$commentId/",
          options: Options(headers: {'Authorization': 'Bearer $tok'}));

      if ((response.statusCode ?? 400) < 300) {
        return true;
      } else {
        throw Failure(message: response.data.toString());
      }
    } on Exception catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future<bool?> likeComment(int id) async {
    try {
      String? tok = await token.getToken();
      Response response = await dio.post(
          "http://167.71.92.176/posts/comments/$id/like/",
          options: Options(headers: {'Authorization': 'Bearer $tok'}));
      if ((response.statusCode ?? 400) < 300) {
        return true;
      } else {
        throw Failure(message: response.data.toString());
      }
    } on Exception catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future<bool?> likePost(int id) async {
    try {
      String? tok = await token.getToken();
      Response response = await dio.post("http://167.71.92.176/posts/$id/like/",
          options: Options(headers: {'Authorization': 'Bearer $tok'}));
      if ((response.statusCode ?? 400) < 300) {
        return true;
      } else {
        throw Failure(message: response.data.toString());
      }
    } on Exception catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future<bool> blockUser(int id) async {
    try {
      String? tok = await token.getToken();
      Response response = await dio.post(
          "http://167.71.92.176/profile/$id/block/",
          options: Options(headers: {'Authorization': 'Bearer $tok'}));

      if ((response.statusCode ?? 400) < 300) {
        return true;
      } else {
        throw Failure(message: response.data.toString());
      }
    } on Exception catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future<bool> deletePost(int id) async {
    try {
      String? tok = await token.getToken();
      Response response = await dio.delete("http://167.71.92.176/posts/$id/",
          options: Options(headers: {'Authorization': 'Bearer $tok'}));
      if ((response.statusCode ?? 400) < 300) {
        return true;
      } else {
        throw Failure(message: response.data.toString());
      }
    } on Exception catch (e) {
      throw Failure(message: e.toString());
    }
  }

  Future<String> GetUserinfoAvatar(int id) async {
    try {
      String? tok = await token.getToken();
      Response response = await dio.get("http://167.71.92.176/profile/$id/",
          options: Options(headers: {'Authorization': 'Bearer $tok'}));
      if ((response.statusCode ?? 400) < 300) {
        print(response.data["avatar"]);
        return response.data["avatar"];
      } else {
        throw Failure(message: response.data.toString());
      }
    } on Exception catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
