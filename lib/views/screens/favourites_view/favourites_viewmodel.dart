import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/services/api_preferences.dart';
import 'package:rick_and_morty/services/api_services.dart';

class FavouritesViewmodel extends ChangeNotifier {
  final _preferencesService = locator<ApiPreferences>();
  final _apiService = locator<ApiServices>();

  List<int> _favourites = [];
  List<CharactersModel> _characters = [];

  List<CharactersModel> get characters => _characters;

  void getFavourites() {
    _favourites = _preferencesService.getSavedCharacters();
    _getCharacters();
  }

  void _getCharacters() async {
    _characters = await _apiService.getMultipleCharacters(_favourites);
    notifyListeners();
  }
}
