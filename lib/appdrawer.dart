import 'package:fitness_app/imports.dart';
import 'package:fitness_app/screens/settings.dart';
import 'package:fitness_app/timer_scaffold.dart';


class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Widget page = const Placeholder();
  late Icon icon;
  var index = 0;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        page = TimerScaffold(list: cardioList, boxName: 'Cardio');
        break;
      case 1:
        page = TimerScaffold(list: sprintList, boxName: 'Sprint');
        break;
      case 2:
        page = TimerScaffold(list: cyclingList, boxName: 'Cycling');
        break;
      case 3:
        page = const Placeholder();
        break;
      case 4:
        page = const Placeholder();
        break;
      case 5:
        page = const SettingsPage();
        break;
    }

    return Scaffold(
      drawer: NavigationDrawer(
        backgroundColor: Color(0xFF071b2f),
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
              child: BuildText(text: 'Hey ${user.get('name')}!', size: 1.5),
            ),
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
                icon: Icon(Icons.fitness_center_rounded),
                label: Text('Workout')),
            const NavigationDrawerDestination(
                icon: Icon(Icons.account_circle), 
                label: Text('User data')),
            const NavigationDrawerDestination(
                icon: Icon(Icons.settings), label: Text('Settings')),
          ]),
      appBar: AppBar(
        backgroundColor: const Color(0xFF001e3c),
        title: Text((index == 0) ? 'Cardio':
        (index == 1) ? 'Sprint':
        (index == 2)? 'Cycling':
        (index == 3)? 'Workouts':
        (index == 0)? 'User data':
        'Settings')
      ),
      backgroundColor: const Color(0xFF001e3c),
      body: page,
    );
  }
}
