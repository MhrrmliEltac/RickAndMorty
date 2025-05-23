import 'package:flutter/foundation.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/models/characters_model.dart';
import 'package:rick_and_morty/models/location_model.dart';
import 'package:rick_and_morty/services/api_services.dart';

class LocationViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiServices>();
  LocationResponse? _locationModel;
  LocationResponse? get locationModel => _locationModel;

  LocationModel? _singleLocationModel;
  LocationModel? get singleLocationModel => _singleLocationModel;

  List<int> _residentsIds = [];
  List<int> get residentsIds => _residentsIds;

  List<CharactersModel> _charactersByResidents = [];
  List<CharactersModel> get charactersByResidents => _charactersByResidents;

  void getLocation() async {
    _locationModel = await _apiService.getLocation();
    notifyListeners();
  }

  void getLocationById(int? id) async {
    _singleLocationModel = await _apiService.getSingleLocation(id: id);
    _residentsIds =
        _singleLocationModel!.residents
            .map((e) => int.parse(e.split('/').last))
            .toList();
    if (_residentsIds.length == 1) {
      _charactersByResidents = [
        await _apiService.getSingleCharacter(id: _residentsIds[0]),
      ];
    } else {
      _charactersByResidents = await _apiService.getMultipleCharacters(
        _residentsIds,
      );
    }
    notifyListeners();
  }

  void clear() {
    _locationModel = null;
    _singleLocationModel = null;
    _residentsIds = [];
    _charactersByResidents = [];
  }

  

}
