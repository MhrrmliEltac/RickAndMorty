class Character {
  CharacterInfo info;
  final List<CharactersModel> characters;

  Character({required this.info, required this.characters});

  factory Character.fromJson(Map<String, dynamic> json) {
    final info = CharacterInfo.fromJson(json["info"]);
    final characters =
        (json["results"] as List)
            .map((e) => CharactersModel.fromJson(e))
            .toList();

    return Character(info: info, characters: characters);
  }
}

class CharacterInfo {
  final int count;
  final int pages;
  final String next;
  final String prev;

  CharacterInfo(this.count, this.next, this.pages, this.prev);

  factory CharacterInfo.fromJson(Map<String, dynamic> json) {
    return CharacterInfo(
      json["count"] ?? 0,
      json["next"] ?? '',
      json["pages"] ?? 0,
      json["prev"] ?? '',
    );
  }
}

class CharactersModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final CharacterLocation location;
  final CharacterOrigin origin;
  final List<String> episodes;

  CharactersModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.location,
    required this.origin,
    required this.episodes,
  });

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    return CharactersModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      status: json["status"] ?? '',
      species: json["species"] ?? '',
      gender: json["gender"] ?? '',
      image: json["image"] ?? '',
      location: CharacterLocation.fromJson(json["location"] ?? {}),
      origin: CharacterOrigin.fromJson(json["origin"] ?? {}),
      episodes: List<String>.from(json["episode"] ?? []),
    );
  }
}

class CharacterLocation {
  final String name;
  final String url;

  CharacterLocation(this.name, this.url);

  CharacterLocation.fromJson(Map<String, dynamic> json)
    : name = json["name"] ?? "",
      url = json["url"] ?? "";
}

class CharacterOrigin {
  final String name;
  final String url;

  CharacterOrigin(this.name, this.url);

  CharacterOrigin.fromJson(Map<String, dynamic> json)
    : name = json["name"] ?? "",
      url = json["url"] ?? "";
}
