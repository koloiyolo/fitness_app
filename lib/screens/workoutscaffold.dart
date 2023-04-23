import 'package:fitness_app/imports.dart';
import 'package:fitness_app/screens/workoutpages/workoutlist.dart';
import 'package:fitness_app/screens/workoutpages/workoutpresets.dart';

class WorkoutScaffold extends StatefulWidget {
  const WorkoutScaffold({super.key});

  @override
  State<WorkoutScaffold> createState() => _WorkoutScaffoldState();
}

class _WorkoutScaffoldState extends State<WorkoutScaffold> {
  Widget page = const Placeholder();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        page = const WorkoutList();
        break;
      case 1:
        page = const Placeholder();
        break;
      case 2:
        page = const WorkoutPresetsPage();
        break;
    }

    return Column(
      children: [
        Expanded(child: page),
        NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) {
            setState(() {
              index = value;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.fitness_center_rounded),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_rounded),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: '',
            ),
          ],
        )
      ],
    );
  }
}
