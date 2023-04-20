import 'package:fitness_app/app_scaffold.dart';
import 'package:fitness_app/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box user;

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('user');
  user = Hive.box('user');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorSchemeSeed: Colors.green[400],
            useMaterial3: true,
            brightness: Brightness.light),
        darkTheme: ThemeData(
            colorSchemeSeed: Colors.blue,
            useMaterial3: true,
            brightness: Brightness.dark),
        themeMode: ThemeMode.dark,
        home: (user.isEmpty) ? const SplashScreen() : AppScaffold());
  }
}
