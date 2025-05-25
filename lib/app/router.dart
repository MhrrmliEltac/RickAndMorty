import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/views/app_view.dart';
import 'package:rick_and_morty/views/screens/characterinfo_view/characterinfo_view.dart';
import 'package:rick_and_morty/views/screens/characterinfo_view/characterinfo_viewmodel.dart';
import 'package:rick_and_morty/views/screens/characters_view/characters_view.dart';
import 'package:rick_and_morty/views/screens/characters_view/characters_viewmodel.dart';
import 'package:rick_and_morty/views/screens/favourites_view/favourites_view.dart';
import 'package:rick_and_morty/views/screens/favourites_view/favourites_viewmodel.dart';
import 'package:rick_and_morty/views/screens/locations_view/location_viewmodel.dart';
import 'package:rick_and_morty/views/screens/locations_view/locations_view.dart';
import 'package:rick_and_morty/views/screens/locationsinfo_view/locationinfo_view.dart';
import 'package:rick_and_morty/views/screens/sectioninfo_view/sectioninfo_view.dart';
import 'package:rick_and_morty/views/screens/sections_view/section_viewmodel.dart';
import 'package:rick_and_morty/views/screens/sections_view/sections_view.dart';

final _routerKey = GlobalKey<NavigatorState>();

class AppRoutes {
  AppRoutes._();

  static const String characters = '/';
  static const String favourites = '/favourites';
  static const String sections = '/sections';

  static const String profileRoutes = "/characterInfo";
  // static const String characterProfile = "character";

  static const String locationRoute = "/locationInfo";
  static const String locations = '/locations';

  static const String sectionInfo = "/sectionInfo";
}

final router = GoRouter(
  navigatorKey: _routerKey,
  initialLocation: AppRoutes.characters,
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) =>
              AppView(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.characters,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => CharactersViewmodel(),
                    child: const CharactersView(),
                  ),
              routes: [
                GoRoute(
                  path: AppRoutes.profileRoutes,
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create: (context) => CharacterInfoViewModel(),
                        child: CharacterinfoView(
                          id: (state.extra as int?) ?? 0,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.favourites,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => FavouritesViewmodel(),
                    child: FavouritesView(),
                  ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.locations,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => LocationViewmodel(),
                    child: const LocationsView(),
                  ),
              routes: [
                GoRoute(
                  path: AppRoutes.locationRoute,
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create: (context) => LocationViewmodel(),
                        child: LocationInfoView(id: (state.extra as int?) ?? 0),
                      ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.sections,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => SectionViewModel(),
                    child: SectionsView(),
                  ),
              routes: [
                GoRoute(
                  path: AppRoutes.sectionInfo,
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create: (context) => SectionViewModel(),
                        child: SectionInfoView(id: (state.extra as int?) ?? 0),
                      ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
