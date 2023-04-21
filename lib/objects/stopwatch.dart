import 'package:fitness_app/imports.dart';
import 'package:fitness_app/screens/stopwatchtimer.dart';

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
  String dateToString(DateTime datetime) {
    return (datetime.month == 1)
        ? '${datetime.day} January ${datetime.year}'
        : (datetime.month == 2)
            ? '${datetime.day} February ${datetime.year}'
            : (datetime.month == 3)
                ? '${datetime.day} March ${datetime.year}'
                : (datetime.month == 4)
                    ? '${datetime.day} April ${datetime.year}'
                    : (datetime.month == 5)
                        ? '${datetime.day} May ${datetime.year}'
                        : (datetime.month == 6)
                            ? '${datetime.day} June ${datetime.year}'
                            : (datetime.month == 7)
                                ? '${datetime.day} July ${datetime.year}'
                                : (datetime.month == 8)
                                    ? '${datetime.day} August ${datetime.year}'
                                    : (datetime.month == 9)
                                        ? '${datetime.day} September ${datetime.year}'
                                        : (datetime.month == 10)
                                            ? '${datetime.day} October ${datetime.year}'
                                            : (datetime.month == 11)
                                                ? '${datetime.day} November ${datetime.year}'
                                                : '${datetime.day} December ${datetime.year}';
  }

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

List<StopWatch> runningList = [];
