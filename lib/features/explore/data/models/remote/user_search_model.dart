import 'package:trend/features/explore/domain/entities/user_search.dart';

class UserSearchModel extends UserSearch {
  UserSearchModel(
      {required super.count,
      required super.next,
      required super.previous,
      required super.results});

  factory UserSearchModel.fromJson(Map<String, dynamic> json) {
    return UserSearchModel(
      count: json["count"],
      next: json["next"],
      previous: json["previous"],
      results: json["results"] == null
          ? null
          : ResultsModel.fromJson(json["results"]),
    );
  }
}

class ResultsModel extends Results {
  ResultsModel({required super.metadata, required super.users});

  factory ResultsModel.fromJson(Map<String, dynamic> json) {
    return ResultsModel(
      metadata: json["metadata"] == null
          ? null
          : MetadataModel.fromJson(json["metadata"]),
      users: json["users"] == null
          ? []
          : List<User>.from(
              json["users"]!.map((x) => UserModel.fromJson(x))),
    );
  }
}

class MetadataModel extends Metadata {
  MetadataModel({required super.totalCount, required super.query});

  factory MetadataModel.fromJson(Map<String, dynamic> json) {
    return MetadataModel(
      totalCount: json["total_count"],
      query: json["query"],
    );
  }
}

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.username,
      required super.email,
      required super.fullName,
      required super.avatar});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      fullName: json["full_name"],
      avatar: json["avatar"],
    );
  }
}
