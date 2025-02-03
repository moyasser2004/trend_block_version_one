import '../../../domain/entities/location_search.dart';

class LocationsSearchModel extends LocationsSearch {
  LocationsSearchModel(
      {required super.count,
      required super.next,
      required super.previous,
      required super.results});

  factory LocationsSearchModel.fromJson(Map<String, dynamic> json) {
    return LocationsSearchModel(
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
  ResultsModel({required super.locations});

  factory ResultsModel.fromJson(Map<String, dynamic> json) {
    return ResultsModel(
      locations: json["locations"] == null
          ? []
          : List<Location>.from(
              json["locations"]!.map((x) => LocationModel.fromJson(x))),
    );
  }
}

class LocationModel extends Location {
  LocationModel(
      {required super.id,
      required super.locationName,
      required super.slug,
      required super.city,
      required super.country,
      required super.latitude,
      required super.longitude,
      required super.radius,
      required super.description,
      required super.postsCount,
      required super.lastActivity});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json["id"],
      locationName: json["location_name"],
      slug: json["slug"],
      city: json["city"],
      country: json["country"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      radius: json["radius"],
      description: json["description"],
      postsCount: json["posts_count"],
      lastActivity: json["last_activity"],
    );
  }
}
