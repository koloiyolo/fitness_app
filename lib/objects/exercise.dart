import 'package:fitness_app/imports.dart';

class Exercise {
  String name;
  int sets;
  int reps;
  bool isDone;

  Exercise(
      {required this.name,
      required this.sets,
      required this.reps,
      required this.isDone});

  List toList() {
    return [name, sets, reps, isDone];
  }
}

List exercisesToList(List<Exercise> exercises) {
  List dummy = [];
  for(var exercise in exercises){
    dummy.add(exercise.toList());
  }
  return dummy;
}

List<Exercise> exercisesFromList(List exercises) {
  List<Exercise> dummy = [];
  for (var exercise in exercises) {
    dummy.add(exerciseFromList(exercise));
  }
  return dummy;
}

Exercise exerciseFromList(List list) {
  return Exercise(name: list[0], sets: list[1], reps: list[2], isDone: list[3]);
}

class ExerciseDay {
  String date;
  List<Exercise> exercises;

  ExerciseDay({required this.date, required this.exercises});

  List toList() {
    return [date, exercises];
  }
}

ExerciseDay exerciseDayFromList(List list) {
  return ExerciseDay(date: list[0], exercises: list[1]);
}

//main list
List<ExerciseDay> exerciseDays = [];

// preset lists
List<Exercise> monday = [];
List<Exercise> tuesday = [];
List<Exercise> wednesday = [];
List<Exercise> thursday = [];
List<Exercise> friday = [];
List<Exercise> saturday = [];
List<Exercise> sunday = [];
