import 'package:flutter/material.dart';
import 'package:fitness_app/imports.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: (){
        user.deleteAll(user.keys);
      }, child: const Text('Delete user data')),
    );
  }
}