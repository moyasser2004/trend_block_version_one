import 'package:equatable/equatable.dart';

abstract class HashtagsSearchEvent extends Equatable {
  const HashtagsSearchEvent();

  List<Object?> get props => [];
}

class HashtagsEvent extends HashtagsSearchEvent {
  final String query;
  const HashtagsEvent(this.query);
}

class GetSearchInitialEvent extends HashtagsSearchEvent {}

