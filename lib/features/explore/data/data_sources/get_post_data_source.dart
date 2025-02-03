import 'package:dio/dio.dart';
import 'package:trend/features/explore/data/models/remote/get_all_post_model.dart';
import 'package:trend/features/explore/data/models/remote/search_model.dart';
import 'package:trend/features/explore/data/models/remote/user_search_model.dart';
import 'package:trend/shared/core/shared_preferences.dart';
import '../../../../shared/const/app_links.dart';
import '../../../../shared/core/error_model/error_server_model.dart';
import '../../../../shared/core/network/server_exception.dart';
import '../models/remote/hashtags_model.dart';
import '../models/remote/location_search_model.dart';

abstract class BasePostDataSource {
  Future<AllPostModel> getAllPosts();

  Future<AllPostModel> getPostWithPageNumber(String pageNumber);

  Future<PostSearchModel> forYouSearch(String query);

  Future<UserSearchModel> UserSearch(String query);

  Future<SearchHashtagsModel> HashtagsSearch(String query);

  Future<LocationsSearchModel> LocationSearch(String query);
}

class PostDataSource extends BasePostDataSource {
  final tok = token.getToken() ??
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzcwMDMwNzE2LCJpYXQiOjE3Mzg0OTQ3MTYsImp0aSI6ImJlM2ZmZGM4MGRlNTQ5MDhhYzZhMDZlMjYzNmQ1ZGE1IiwidXNlcl9pZCI6MTg1fQ.qfTGS6aLg8AKXAu-tod_R4GB8Oc8mZKngT7LAp97SqE";

  @override
  Future<AllPostModel> getPostWithPageNumber(
      String pageNumber) async {
    Response response = await Dio().get(
      pageNumber,
      options: Options(
        headers: {'Authorization': 'Bearer $tok'},
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return AllPostModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorServerModel: ErrorServerModel.fromJson(response.data));
    }
  }

  @override
  Future<AllPostModel> getAllPosts() async {
    Response response = await Dio().get(
      ApiEndpoints.getAllPosts,
      options: Options(
        headers: {'Authorization': 'Bearer $tok'},
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return AllPostModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorServerModel: ErrorServerModel.fromJson(response.data));
    }
  }

  @override
  Future<PostSearchModel> forYouSearch(String query) async {
    Response response = await Dio().get(
      ApiEndpoints.forYouPostSearch(query),
      options: Options(
        headers: {'Authorization': 'Bearer $tok'},
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return PostSearchModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorServerModel: ErrorServerModel.fromJson(response.data));
    }
  }

  @override
  Future<UserSearchModel> UserSearch(String query) async {
    Response response = await Dio().get(
      ApiEndpoints.getUserSearch(query),
      options: Options(
        headers: {'Authorization': 'Bearer $tok'},
      ),
    );
    print(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserSearchModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorServerModel: ErrorServerModel.fromJson(response.data));
    }
  }

  @override
  Future<SearchHashtagsModel> HashtagsSearch(String query) async {
    Response response = await Dio().get(
      ApiEndpoints.getTrendingHashtags(query),
      options: Options(
        headers: {'Authorization': 'Bearer $tok'},
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return SearchHashtagsModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorServerModel: ErrorServerModel.fromJson(response.data));
    }
  }

  @override
  Future<LocationsSearchModel> LocationSearch(String query) async {
    Response response = await Dio().get(
      ApiEndpoints.getLocationSearch(query),
      options: Options(
        headers: {'Authorization': 'Bearer $tok'},
      ),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return LocationsSearchModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorServerModel: ErrorServerModel.fromJson(response.data));
    }
  }
}
