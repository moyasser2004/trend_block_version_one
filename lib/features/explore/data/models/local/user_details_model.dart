import 'package:equatable/equatable.dart';

class UserDetailsModel extends Equatable {
  final String id;
  final String username;
  final String full_name;
  final String email;
  final String avatar;

  UserDetailsModel(
      {required this.id,
      required this.username,
      required this.full_name,
      required this.email,
      required this.avatar});

  @override
  List<Object?> get props => [id, username, full_name, email, avatar];
}
