import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/locator.dart';
import 'package:rick_and_morty/app/router.dart';
import 'package:rick_and_morty/app/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Bu, SharedPreferences üçün vacibdir
  await setupLocator(); // await əlavə edildi
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
