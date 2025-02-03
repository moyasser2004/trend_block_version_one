import 'package:equatable/equatable.dart';

abstract class LocationSearchEvent extends Equatable {
  const LocationSearchEvent();

  List<Object?> get props => [];
}

class LocationEvent extends LocationSearchEvent {
  final String query;

  const LocationEvent(this.query);
}

class LocationInitialEvent extends LocationSearchEvent {}
