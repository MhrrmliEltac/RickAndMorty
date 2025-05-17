import 'package:shared_preferences/shared_preferences.dart';

class ApiPreferences {
  final SharedPreferences prefs;

  ApiPreferences({required this.prefs});

  Future<void> setDataPreferences(int id) async {
    final String idToString = id.toString();
    final List<String> idList = [];
    idList.add(idToString);
    try {
      await prefs.setStringList("id", idList);
    } catch (e) {
      rethrow;
    }
  }
}
