import 'package:fitness_app/objects/user.dart';
import 'package:fitness_app/screens/settings.dart';
import 'package:fitness_app/screens/splash.dart';

import 'imports.dart';

class AppScaffold extends StatefulWidget {
  AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  late Widget page;

  int index = 0;


  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        page = const Placeholder();
        break;
      case 1:
        page = const Placeholder();
        break;
      case 2:
        page = const SettingsPage();
        break;
    }
    return Scaffold(
        appBar: AppBar(title: Text('Hey ${user.get('name')}')),
        body: Column(
          children: [
            Expanded(child: page),
            NavigationBar(destinations: const [
              NavigationDestination(icon: Icon(Icons.timer), label: ''),
              NavigationDestination(icon: Icon(Icons.list), label: ''),
              NavigationDestination(icon: Icon(Icons.settings), label: ''),
            ],
            selectedIndex: index,
            onDestinationSelected: (value) => setState(() {
              index = value;
            })
            ),
          ],
        ));
  }
}