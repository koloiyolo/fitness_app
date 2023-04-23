import 'package:fitness_app/imports.dart';

class Exercise
{
  String name;
  int sets;
  int reps;


  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
  });
  List toList(){
    return [name, sets, reps];
  }
}


