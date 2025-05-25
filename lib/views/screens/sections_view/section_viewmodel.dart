import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/models/episode_model.dart';
import 'package:rick_and_morty/services/api_services.dart';

class SectionViewModel extends ChangeNotifier {
  final _apiServices = locator<ApiServices>();
  EpisodeResponse? _episodeModel;
  EpisodeResponse? get episodeModel => _episodeModel;

  List<int> _episodeIds = [];
  List<int> get episodeIds => _episodeIds;

  List<CharactersModel> _charactersByEpisodes = [];
  List<CharactersModel> get charactersByEpisodes => _charactersByEpisodes;

  EpisodeModel? _episode;
  EpisodeModel? get episode => _episode;

  Future<void> getAllEpisodesModel() async {
    try {
      _episodeModel = await _apiServices.getAllEpisodes();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getSingleEpisode({required int? id}) async {
    try {
      _episode = await _apiServices.getSingleEpisode(id: id);
      _episodeIds =
          episode!.characters.map((e) => int.parse(e.split('/').last)).toList();
      if (_episodeIds.length == 1) {
        _charactersByEpisodes = [
          await _apiServices.getSingleCharacter(id: _episodeIds[0]),
        ];
      } else {
        _charactersByEpisodes = await _apiServices.getMultipleCharacters(
          _episodeIds,
        );
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
