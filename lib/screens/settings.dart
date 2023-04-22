import 'package:fitness_app/imports.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: (){
        user.deleteAll(user.keys);
      }, child: const Text('Delete user data')),
      ElevatedButton(onPressed: (){
        data.deleteAll(user.keys);
      }, child: const Text('Delete all data')),
      ],
      
    );
  }
}