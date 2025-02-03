import 'package:equatable/equatable.dart';

abstract class ForYouSearchEvent extends Equatable {
  const ForYouSearchEvent();

  List<Object?> get props => [];
}

class PostSearchEvent extends ForYouSearchEvent {
  final String query;
  const PostSearchEvent(this.query);
}

class UserSearchEvent extends ForYouSearchEvent {
  final String query;
  const UserSearchEvent(this.query);
}

class GetSearchInitialEvent extends ForYouSearchEvent {}
