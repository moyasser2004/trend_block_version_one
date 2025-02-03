import 'package:equatable/equatable.dart';

class UserSearch extends Equatable {
  final int? count;
  final String? next;
  final dynamic previous;
  final Results? results;

  const UserSearch({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  @override
  List<Object?> get props => [
        count,
        next,
        previous,
        results,
      ];
}

class Results extends Equatable {
  final Metadata? metadata;
  final List<User> users;

  Results({
    required this.metadata,
    required this.users,
  });

  @override
  List<Object?> get props => [
        metadata,
        users,
      ];
}

class Metadata extends Equatable {
  final int? totalCount;
  final String? query;

  Metadata({
    required this.totalCount,
    required this.query,
  });

  @override
  List<Object?> get props => [
        totalCount,
        query,
      ];
}

class User extends Equatable {
  final int? id;
  final String? username;
  final String? email;
  final String? fullName;
  final String? avatar;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.avatar,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        fullName,
        avatar,
      ];
}
