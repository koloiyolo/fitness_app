import 'package:fitness_app/imports.dart';


// time vars
int hours = 0;
int minutes = 0;
int seconds = 0;
int deciseconds = 0;

// time to str vars
String hoursStr = '00';
String minutesStr = '00';
String secondsStr = '00';
String decisecondsStr = '0';

late Timer stopwatch;
bool isStarted = false;
List<String> checkpoints = [];

class StopWatchTimerPage extends StatefulWidget {
  const StopWatchTimerPage({super.key});

  @override
  State<StopWatchTimerPage> createState() => _StopWatchTimerPageState();
}

class _StopWatchTimerPageState extends State<StopWatchTimerPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Expanded(flex: 1, child: SizedBox()),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: BuildText(
              text: '$hoursStr:$minutesStr:$secondsStr:$decisecondsStr',
              size: 4),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: checkpoints.length,
              itemBuilder: (context, index) => Center(
                  child: BuildText(
                      text: '${index+1}. ${checkpoints[index]}', size: 1.8)),
            )),
        const Expanded(flex: 1, child: SizedBox()),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: MaterialButton(
              color: Colors.blueGrey,
              padding: const EdgeInsets.all(8),
              onPressed: newCheckpoint,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.flag),
                  BuildText(text: '   CHECKPOINT  ', size: 1.8)
                ],
              )),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, bottom: 16, top: 16),
          child: MaterialButton(
              padding: const EdgeInsets.all(8),
              color: Colors.blueGrey,
              onPressed: stopWatchPause,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.pause),
                  BuildText(text: '  PAUSE  ', size: 1.8)
                ],
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                  padding: const EdgeInsets.all(8),
                  color: Colors.green,
                  onPressed: stopWatchStart,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.play_arrow),
                      BuildText(text: '  START  ', size: 1.8)
                    ],
                  )),
              MaterialButton(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red,
                  onPressed: stopWatchStop,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.stop),
                      BuildText(text: '  STOP  ', size: 1.8)
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }

  void stopWatchStart() {
    isStarted = true;
    stopwatch = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      // time vars
      if (minutes == 59 && seconds == 59 && deciseconds == 9) {
        hours++;
        minutes = 0;
        seconds = 0;
        deciseconds = 0;
      } else if (seconds == 59 && deciseconds == 9) {
        minutes++;
        seconds = 0;
        deciseconds = 0;
      }
      if (deciseconds == 9) {
        seconds++;
        deciseconds = 0;
      }
      deciseconds++;

      //time to str vars
      hoursStr = convMinSecHour(hours);
      minutesStr = convMinSecHour(minutes);
      secondsStr = convMinSecHour(seconds);
      decisecondsStr = '$deciseconds';
      setState(() {});
    });
  }



  void stopWatchPause() {
    if (isStarted) {
      stopwatch.cancel();
      isStarted = false;
    } else if (minutes != 0 || seconds != 0 || deciseconds != 0 || hours != 0) {
      stopWatchStart();
    }
  }

  void stopWatchStop() {
     if (minutes != 0 || seconds != 0 || deciseconds != 0 || hours != 0) {
      isStarted = false;
      stopwatch.cancel();
      stopWatchList.add(StopWatch(
          hours: hours,
          minutes: minutes,
          seconds: seconds,
          deciseconds: deciseconds,
          date: DateTime.now()));
      hours = 0;
      minutes = 0;
      seconds = 0;
      deciseconds = 0;
      hoursStr = convMinSecHour(hours);
      minutesStr = convMinSecHour(minutes);
      secondsStr = convMinSecHour(seconds);
      decisecondsStr = '$deciseconds';
      setState(() {});
     }
  }

  void newCheckpoint() {
    if(isStarted){
     checkpoints.add('$hoursStr:$minutesStr:$secondsStr:$decisecondsStr'); 
    }
    
  }
}
