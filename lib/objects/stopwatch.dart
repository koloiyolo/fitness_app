import 'package:fitness_app/imports.dart';

class StopWatch {
  late int hours;
  late int minutes;
  late int seconds;
  late int deciseconds;
  late DateTime date;
  List<Checkpoint> checkpoints;

  StopWatch(
      {required this.hours,
      required this.minutes,
      required this.seconds,
      required this.deciseconds,
      required this.date,
      required this.checkpoints
      });

  

  //toList
  List toList() {
    return [hours, minutes, seconds, deciseconds, date.toString(), checkpointsToList(checkpoints)];
  }

  static StopWatch fromList(List stopwatch) {
    return StopWatch(
        hours: stopwatch[0],
        minutes: stopwatch[1],
        seconds: stopwatch[2],
        deciseconds: stopwatch[3],
        date: DateTime.parse(stopwatch[4].toString()),
        checkpoints: checkpointsFromList(stopwatch[5]));
  }

  

  String timeToString() {
    return '$hours:${convMinSecHour(minutes)}:${convMinSecHour(seconds)}:$deciseconds ';
  }
}

List<StopWatch> stopWatchesFromList(List list){
    List<StopWatch> dummy =[];
    for(var element in list){
      dummy.add(StopWatch.fromList(element));
    }
    return dummy;
  }
  List stopWatchesToList(List<StopWatch> list){
    List dummy =[];
    for(var element in list){
      dummy.add(element.toList());
    }
    return dummy;
  }

List<StopWatch> cardioList = [];
List<StopWatch> sprintList = [];
List<StopWatch> cyclingList = [];
