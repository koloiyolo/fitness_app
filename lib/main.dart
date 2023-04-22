import 'package:fitness_app/appdrawer.dart';
import 'imports.dart';
import 'package:fitness_app/screens/splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box user;
late Box data;

Future<void> main() async {
  //init local DBs
  await Hive.initFlutter();
  await Hive.openBox('user');
  data = await Hive.openBox('data');
  user = Hive.box('user');
  if (data.isNotEmpty) {
    if (data.get('Cardio') != null) {
      cardioList = stopWatchesFromList(data.get('Cardio'));
    }
    if (data.get('Sprint') != null) {
      sprintList = stopWatchesFromList(data.get('Sprint'));
    }
    if (data.get('Cycling') != null) {
      cyclingList = stopWatchesFromList(data.get('Cycling'));
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorSchemeSeed: Colors.blue,
            useMaterial3: true,
            brightness: Brightness.light),
        darkTheme: ThemeData(
            colorSchemeSeed: Colors.blue,
            useMaterial3: true,
            brightness: Brightness.dark),
        themeMode: ThemeMode.system,
        home: (user.isEmpty) ? const SplashScreen() : const AppDrawer());
  }
}
