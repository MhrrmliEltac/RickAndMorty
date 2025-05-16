import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppView({super.key, required this.navigationShell});

  @override
  Widget build(context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        indicatorColor: Colors.transparent,
        destinations: [
          _menuItem(
            index: 0,
            currentIndex: navigationShell.currentIndex,
            icon: Icons.face,
            label: "Karakterler",
            context: context,
          ),
          _menuItem(
            index: 1,
            currentIndex: navigationShell.currentIndex,
            icon: Icons.bookmark,
            label: "Favoriler",
            context: context,
          ),
          _menuItem(
            index: 2,
            currentIndex: navigationShell.currentIndex,
            icon: Icons.location_on,
            label: "Konumlar",
            context: context,
          ),
          _menuItem(
            index: 3,
            currentIndex: navigationShell.currentIndex,
            icon: Icons.menu,
            label: "Bolumler",
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required int index,
    required int currentIndex,
    required IconData icon,
    required String label,
    required BuildContext context,
  }) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(color: Theme.of(context).colorScheme.primary);
          }
          return TextStyle(color: Theme.of(context).colorScheme.tertiary);
        }),
      ),
      child: NavigationDestination(
        icon: Icon(
          icon,
          color:
              currentIndex == index
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.tertiary,
        ),
        label: label,
      ),
    );
  }
}
