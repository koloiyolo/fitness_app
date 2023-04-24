import 'package:fitness_app/imports.dart';
import 'package:fitness_app/screens/settings.dart';
import 'package:fitness_app/screens/userpage.dart';
import 'package:fitness_app/screens/workoutscaffold.dart';
import 'package:fitness_app/screens/timer_scaffold.dart';




class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {


 @override
  void initState() {
    super.initState();

    //check GPS perms
    getLocationPermission();
  }

  Widget page = const Placeholder();
  late Icon icon;
  var index = 0;


  @override
  Widget build(BuildContext context) {

    //AppDrawer logic
    switch (index) {
      case 0:
        page = const WorkoutScaffold();
        break;
      case 1:
        page = TimerScaffold(list: cardioList, boxName: 'Cardio');
        break;
      case 2:
        page = TimerScaffold(list: sprintList, boxName: 'Sprint');
        break;
      case 3:
        page = TimerScaffold(list: cyclingList, boxName: 'Cycling');
        break;
      case 4:
        page = const UserPage();
        break;
      case 5:
        page = const SettingsPage();
        break;
    }

    return Scaffold(
      drawer: NavigationDrawer(
          selectedIndex: index,
          onDestinationSelected: (value) {
            setState(() {
                index = value;
              });
              Navigator.pop(context);
          },
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Hey ${user.get('name')}!',
              style: const TextStyle(
                fontSize: 25,
                //color: Color.fromARGB(255, 102, 178, 255)
              ),),
            ),
            const NavigationDrawerDestination(
                icon: Icon(Icons.fitness_center_rounded),
                label: Text('Workout')),
            const NavigationDrawerDestination(
                icon: Icon(Icons.directions_run_rounded),
                label: Text('Cardio')),
            const NavigationDrawerDestination(
                icon: Icon(Icons.directions_run_rounded),
                label: Text('Sprint')),
            const NavigationDrawerDestination(
                icon: Icon(Icons.pedal_bike_rounded), 
                label: Text('Cycling')),
            const NavigationDrawerDestination(
                icon: Icon(Icons.account_circle), 
                label: Text('User data')),
            const NavigationDrawerDestination(
                icon: Icon(Icons.settings), label: Text('Settings')),
          ]),
      appBar: AppBar(
        title: Text((index == 0)? 'Workouts':
        (index == 1) ? 'Sprint':
        (index == 2)? 'Cycling':
        (index == 3) ? 'Cardio':
        (index == 4)? '${user.get('name')}\'s profile':
        'Settings')
      ),
      body: page,
    );
  }
}
Future<void> getLocationPermission() async {
    var permissionGranted = await Geolocator.checkPermission();

    if (permissionGranted != LocationPermission.always ||
        permissionGranted != LocationPermission.whileInUse) {
      await Geolocator.requestPermission();
    }

    if (permissionGranted != LocationPermission.always ||
        permissionGranted != LocationPermission.whileInUse) {
    }
  }
