class LocationResponse {
  final LocationInfo info;
  final List<LocationModel> results;

  LocationResponse(this.info, this.results);

  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      LocationInfo.fromJson(json['info']),
      (json['results'] as List).map((e) => LocationModel.fromJson(e)).toList(),
    );
  }
}

class LocationInfo {
  final int count;
  final int pages;
  final String next;
  final String prev;

  LocationInfo(this.count, this.next, this.pages, this.prev);

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      json["count"] ?? 0,
      json["next"] ?? '',
      json["pages"] ?? 0,
      json["prev"] ?? '',
    );
  }
}

class LocationModel {
  final num id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;
  final String url;
  final String created;

  LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as num,
      name: json['name'] as String,
      type: json['type'] as String,
      dimension: json['dimension'] as String,
      residents: List<String>.from(json['residents'] as List),
      url: json['url'] as String,
      created: json['created'] as String,
    );
  }
}
