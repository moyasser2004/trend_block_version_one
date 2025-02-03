import 'package:equatable/equatable.dart';

class HashtagsDetailsModel extends Equatable {
  final String author;
  final String author_id;
  final String created_at;
  final String posts_count;

  HashtagsDetailsModel(
      {required this.author,
      required this.author_id,
      required this.created_at,
      required this.posts_count});

  @override
  List<Object?> get props =>
      [author, author_id, created_at, posts_count];
}
