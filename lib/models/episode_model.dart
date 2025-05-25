class EpisodeResponse {
  final EpisodeInfo info;
  final List<EpisodeModel> results;

  EpisodeResponse({required this.info, required this.results});

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) {
    return EpisodeResponse(
      info: EpisodeInfo.fromJson(json['info']),
      results:
          (json['results'] as List)
              .map((e) => EpisodeModel.fromJson(e))
              .toList(),
    );
  }
}

class EpisodeInfo {
  final int count;
  final int pages;
  final String next;
  final String? prev;

  EpisodeInfo({
    required this.count,
    required this.pages,
    required this.next,
    this.prev,
  });

  factory EpisodeInfo.fromJson(Map<String, dynamic> json) {
    return EpisodeInfo(
      count: json['count'] ?? 0,
      pages: json['pages'] ?? 0,
      next: json['next'] ?? '',
      prev: json['prev'],
    );
  }
}

class EpisodeModel {
  final int id;
  final String name;
  final String episode;
  final List<String> characters;
  final String url;

  EpisodeModel({
    required this.id,
    required this.name,
    required this.episode,
    required this.characters,
    required this.url,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    final rawEpisode = json['episode'] ?? ''; // məsələn: "S01E01"
    String formattedEpisode = rawEpisode;

    // "S01E01" formatını "Bölüm 1 Sezon 1" formatına çevirmək
    final seasonMatch = RegExp(r'S(\d{2})').firstMatch(rawEpisode);
    final episodeMatch = RegExp(r'E(\d{2})').firstMatch(rawEpisode);

    if (seasonMatch != null && episodeMatch != null) {
      final seasonNumber = int.tryParse(seasonMatch.group(1)!) ?? 0;
      final episodeNumber = int.tryParse(episodeMatch.group(1)!) ?? 0;
      formattedEpisode = "Bölüm $episodeNumber Sezon $seasonNumber";
    }

    return EpisodeModel(
      id: json["id"],
      name: json['name'],
      episode: formattedEpisode,
      characters: List<String>.from(json['characters'] ?? []),
      url: json['url'],
    );
  }
}
