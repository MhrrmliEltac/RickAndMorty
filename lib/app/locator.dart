import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/services/api_services.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ApiServices>(() => ApiServices());
}
