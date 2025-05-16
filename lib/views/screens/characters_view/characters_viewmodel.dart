import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/services/api_services.dart';

class CharactersViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiServices>();
  Character? _charactersModel;
  Character? get charactersModdel => _charactersModel;

  void getCharacter() async {
    _charactersModel = await _apiService.getAllCharacter();
    notifyListeners();
  }

  bool isLoading = false;
  int _currentPageIndex = 1;

  void clearInfo() {
    _charactersModel = null;
    _currentPageIndex = 1;
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void getCharacterMore() async {
    if (isLoading) return;

    if (_charactersModel!.info.pages == _currentPageIndex) return;

    setLoading(true);
    final data = await _apiService.getAllCharacter(
      url: _charactersModel!.info.next,
    );
    _currentPageIndex++;
    setLoading(false);
    _charactersModel!.info = data.info;
    _charactersModel!.characters.addAll(data.characters);
    notifyListeners();
  }

  void searchCharacterByName(String name) async {
    clearInfo();
    notifyListeners();
    _charactersModel = await _apiService.getAllCharacter(args: {"name": name});
    notifyListeners();
  }
}
