import 'package:fitness_app/imports.dart';

const LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 20,
);

late Position currentPosition;
bool positionGranted = false;

class StopWatchTimerPage extends StatefulWidget {
  final int mod;
  final String box;
  final List<StopWatch> list;
  const StopWatchTimerPage({
    required this.box, 
    required this.list, 
    required this.mod,
    super.key});

  @override
  State<StopWatchTimerPage> createState() => _StopWatchTimerPageState();
}

class _StopWatchTimerPageState extends State<StopWatchTimerPage> {
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

  String positionGrantedString = 'Fetching GPS.';
  Icon positionGrantedIcon = const Icon(Icons.gps_fixed_rounded);
  late Position lastPosition;
  List<Checkpoint> locationCheckpoints = [];

  // collect GPS locations as stream
  final StreamSubscription<Position> positionStream =
      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position? position) {
    if (position != null) {
      currentPosition = position;
    }
  });

  void waitForPosition(int i) {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        positionGrantedIcon = (i % 2 == 0)
            ? const Icon(Icons.gps_fixed_rounded)
            : const Icon(Icons.gps_not_fixed_rounded);
        positionGrantedString = (i == 1 || i == 4 || i == 7)
            ? 'Fetching GPS..'
            : (i == 2 || i == 5 || i == 8)
                ? 'Fetching GPS.'
                : 'Fetching GPS...';
        if (i-- == 0) {
          positionGranted = true;
          return;
        } else {
          waitForPosition(i);
        }
      });
    });
  }

  @override
  void initState() {
    if (!positionGranted) {
      waitForPosition(8);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: BuildText(
              text: '$hoursStr:$minutesStr:$secondsStr:$decisecondsStr',
              size: 4),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 8,
          child: ListView.builder(
            itemCount: locationCheckpoints.length,
            itemBuilder: (context, index) => Center(
              child: BuildText(
                  text:
                      '${locationCheckpoints[index].time}. ${locationCheckpoints[index].distance.round()} m',
                  size: 1.5),
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        BuildText(
            text: 'Total:   ${sumOfDistance(locationCheckpoints).round()}m',
            size: 2),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, bottom: 15, top: 15),
          child: MaterialButton(
            visualDensity: VisualDensity.comfortable,
            padding: const EdgeInsets.all(21),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.grey[600],
            onPressed: pauseStopWatch,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.pause),
                BuildText(text: '  P A U S E  ', size: 1.8)
              ],
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, bottom: 30, top: 15),
          child: MaterialButton(
            visualDensity: VisualDensity.comfortable,
            padding: const EdgeInsets.all(21),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: (!positionGranted)
                ? Colors.grey[600]
                : (isStarted)
                    ? Colors.red
                    : Colors.amber[800],
            onPressed: (!positionGranted)
                ? () {}
                : (isStarted)
                    ? stopWatchStop
                    : startStopWatch,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: (!positionGranted)
                  ? [
                      positionGrantedIcon,
                      BuildText(text: positionGrantedString, size: 1.8)
                    ]
                  : (isStarted)
                      ? const [
                          Icon(Icons.stop),
                          BuildText(text: '  S T O P  ', size: 1.8)
                        ]
                      : const [
                          Icon(Icons.play_arrow_rounded),
                          BuildText(text: '  S T A R T  ', size: 1.8)
                        ],
            ),
          ),
        ),
      ],
    );
  }

  void startStopWatch() {
    if (!isStarted) {
      isStarted = true;
      stopwatch = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if ((seconds % widget.mod == 0) && deciseconds == 0) {
          newCheckpoint();
        }

        // time vars
        deciseconds++;
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
        if (deciseconds == 10) {
          seconds++;
          deciseconds = 0;
        }

        //time to str vars
        hoursStr = convMinSecHour(hours);
        minutesStr = convMinSecHour(minutes);
        secondsStr = convMinSecHour(seconds);
        decisecondsStr = '$deciseconds';
        setState(() {});
      });
    }
  }

  void pauseStopWatch() {
    if (isStarted) {
      stopwatch.cancel();
      isStarted = false;
    } else if (minutes != 0 || seconds != 0 || deciseconds != 0 || hours != 0) {
      startStopWatch();
    }
  }

  void stopWatchStop() {
    if (minutes != 0 || seconds != 0 || deciseconds != 0 || hours != 0) {
      isStarted = false;
      stopwatch.cancel();
      widget.list.add(
        StopWatch(
            hours: hours,
            minutes: minutes,
            seconds: seconds,
            deciseconds: deciseconds,
            date: DateTime.now(),
            checkpoints: locationCheckpoints),
      );
      data.delete(widget.box);
      data.put(widget.box, stopWatchesToList(widget.list));
      hours = 0;
      minutes = 0;
      seconds = 0;
      deciseconds = 0;
      hoursStr = convMinSecHour(hours);
      minutesStr = convMinSecHour(minutes);
      secondsStr = convMinSecHour(seconds);
      decisecondsStr = '$deciseconds';
      locationCheckpoints = [];
      setState(() {});
    }
  }

  void newCheckpoint() {
    if (locationCheckpoints.isEmpty) {
      locationCheckpoints.add(
        Checkpoint(
            longitude: currentPosition.longitude,
            latitude: currentPosition.latitude,
            time: '00:00:00:0',
            distance: 0),
      );
    } else {
      locationCheckpoints.add(
        Checkpoint(
          longitude: currentPosition.longitude - lastPosition.longitude,
          latitude: currentPosition.latitude - lastPosition.latitude,
          time: '$hoursStr:$minutesStr:$secondsStr:$decisecondsStr',
          distance: Geolocator.distanceBetween(
              lastPosition.latitude,
              lastPosition.longitude,
              currentPosition.latitude,
              currentPosition.longitude),
        ),
      );
    }
    lastPosition = currentPosition;
  }
}
