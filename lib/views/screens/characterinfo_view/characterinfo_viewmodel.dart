import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/models/episode_model.dart';
import 'package:rick_and_morty/services/api_services.dart';

class CharacterInfoViewModel extends ChangeNotifier {
  final _apiService = locator<ApiServices>();
  CharactersModel? _character;
  CharactersModel? get character => _character;

  List<EpisodeModel>? _episodes;
  List<EpisodeModel>? get episodes => _episodes;

  bool isLoading = false;
  void setLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  void getSingleCharacter(int id) async {
    setLoading(true);
    final data = await _apiService.getSingleCharacter(id: id);
    _character = data;

    final episodeIds =
        _character!.episodes.map((e) {
          return int.parse(e.split("/").last);
        }).toList();
    await getMultipleEpisodes(episodeIds);

    setLoading(false);
    notifyListeners();
  }

  Future<void> getMultipleEpisodes(List idList) async {
    final data = await _apiService.getMultipleEpisode(idList);
    _episodes = data;
    notifyListeners();
  }
}
