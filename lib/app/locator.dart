import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/services/api_preferences.dart';
import 'package:rick_and_morty/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton<ApiPreferences>(
    () => ApiPreferences(prefs: prefs),
  );
  locator.registerLazySingleton<ApiServices>(() => ApiServices());
}
