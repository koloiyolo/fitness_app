import 'package:fitness_app/appdrawer.dart';
import 'package:fitness_app/objects/exercise.dart';
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

  //fetch data from DB

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

  //preset lists
  if (data.isNotEmpty) {
    if (data.get('monday') != null) {
      monday = exercisesFromList(data.get('monday'));
    }
    if (data.get('tuesday') != null) {
      tuesday = exercisesFromList(data.get('tuesday'));
    }
    if (data.get('wednesday') != null) {
      wednesday = exercisesFromList(data.get('wednesday'));
    }
    if (data.get('thursday') != null) {
      thursday = exercisesFromList(data.get('thursday'));
    }
    if (data.get('friday') != null) {
      friday = exercisesFromList(data.get('friday'));
    }
    if (data.get('saturday') != null) {
      saturday = exercisesFromList(data.get('saturday'));
    }
    if (data.get('sunday') != null) {
      sunday = exercisesFromList(data.get('sunday'));
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

            //blue

            // colorScheme: const ColorScheme(
            //     brightness: Brightness.dark,
            //     primary: Colors.white,
            //     onPrimary: Color(0xFF071b2f),
            //     secondary: Color(0xFF071b2f),
            //     onSecondary: Colors.blue,
            //     error: Colors.black,
            //     onError: Colors.red,
            //     background: Color(0xFF001e3c),
            //     onBackground: Colors.white,
            //     surface: Color(0xFF001e3c),
            //     onSurface: Colors.white),

            //black/yellow/white

            colorScheme: const ColorScheme(
                brightness: Brightness.dark,
                primary: Colors.white,
                onPrimary: Colors.black,
                secondary: Color.fromARGB(255, 70, 70, 70),
                onSecondary: Colors.amber,
                error: Colors.black,
                onError: Colors.red,
                background: Color.fromARGB(255, 38, 38, 38),
                onBackground: Colors.white,
                surface: Color.fromARGB(255, 38, 38, 38),
                onSurface: Colors.white),
            useMaterial3: true,
            brightness: Brightness.dark),
        themeMode: ThemeMode.system,
        home: (user.isEmpty) ? const SplashScreen() : const AppDrawer());
  }
}
