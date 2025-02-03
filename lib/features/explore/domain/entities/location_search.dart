import 'package:equatable/equatable.dart';



class LocationsSearch extends Equatable {

  final int? count;
  final String? next;
  final dynamic previous;
  final Results? results;
  
  const LocationsSearch({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });
  
  

  @override
  List<Object?> get props => [
    count, next, previous, results, ];
}

class Results extends Equatable {
  final List<Location> locations;
  
  Results({
    required this.locations,
  });
  

  @override
  List<Object?> get props => [
    locations, ];
}

class Location extends Equatable {

  final int? id;
  final String? locationName;
  final String? slug;
  final String? city;
  final String? country;
  final String? latitude;
  final String? longitude;
  final int? radius;
  final String? description;
  final int? postsCount;
  final dynamic lastActivity;


  Location({
    required this.id,
    required this.locationName,
    required this.slug,
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.radius,
    required this.description,
    required this.postsCount,
    required this.lastActivity,
  });
  
  @override
  List<Object?> get props => [
    id, locationName, slug, city, country, latitude, longitude, radius, description, postsCount, lastActivity, ];
}

