import 'package:fitness_app/imports.dart';


// create user
void createUser(String name, int age, int height, double weight, String isMan, DateTime firstLogin){
  user.put('name', name);
  user.put('age', age);
  user.put('height', height);
  user.put('weight', weight);
  user.put('isMan', isMan);
  user.put('firstLogin', firstLogin);
}

