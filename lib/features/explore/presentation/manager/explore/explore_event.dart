import 'package:equatable/equatable.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  List<Object?> get props => [];
}

class GetAllPostsEvent extends ExploreEvent {}

class GetPostWithPageNumberEvent extends ExploreEvent {}
