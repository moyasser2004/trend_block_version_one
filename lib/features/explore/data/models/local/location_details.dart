import 'package:equatable/equatable.dart';

class LocationDetails extends Equatable {
  final String id;
  final String location_name;
  final String slug;
  final String city;
  final String latitude;
  final String longitude;
  final String description;
  final String posts_count;
  final String last_activity;

  LocationDetails({
    required this.id,
    required this.location_name,
    required this.slug,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.posts_count,
    required this.last_activity,
  });

  @override
  List<Object?> get props => [
        id,
        location_name,
        slug,
        city,
        latitude,
        longitude,
        description,
        posts_count,
        last_activity,
      ];
}
