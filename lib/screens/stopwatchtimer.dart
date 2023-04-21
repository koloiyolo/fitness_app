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

late bool positionGranted = true;
late Position lastPosition;
late Position currentPosition;
List<Checkpoint> locationCheckpoints = [];
const LocationSettings locationSettings = LocationSettings(
  accuracy: LocationAccuracy.high,
  distanceFilter: 50,
);

class StopWatchTimerPage extends StatefulWidget {
  const StopWatchTimerPage({super.key});

  @override
  State<StopWatchTimerPage> createState() => _StopWatchTimerPageState();
}

class _StopWatchTimerPageState extends State<StopWatchTimerPage> {
  @override
  void initState() {
    super.initState();
    getLocationPermission();
  }

  final StreamSubscription<Position> positionStream =
      Geolocator.getPositionStream(locationSettings: locationSettings)
          .listen((Position? position) {
    if (position != null) {
      currentPosition = position;
      print(position.latitude);
    }
  });

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
                  text: '${locationCheckpoints[index].time}. ${locationCheckpoints[index].distance.round()} m',
                  size: 1.5),
            ),
          ),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        BuildText(text: 'Total: ${sumOfDistance(locationCheckpoints).round()}m', size: 2),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, bottom: 16, top: 16),
          child: MaterialButton(
            visualDensity: VisualDensity.comfortable,
            padding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: const Color.fromARGB(125, 96, 125, 139),
            onPressed: stopWatchPause,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.pause),
                BuildText(text: '  PAUSE  ', size: 1.8)
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                visualDensity: VisualDensity.comfortable,
                padding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.green,
                onPressed: stopWatchStart,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.play_arrow),
                    BuildText(text: '  START  ', size: 1.8)
                  ],
                ),
              ),
              MaterialButton(
                visualDensity: VisualDensity.comfortable,
                padding: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.red,
                onPressed: stopWatchStop,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.stop),
                    BuildText(text: '  STOP  ', size: 1.8)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void stopWatchStart() {
    isStarted = true;
    stopwatch = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if ((seconds % 30 == 0) && deciseconds == 0 && positionGranted) {
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
      stopWatchList.add(
        StopWatch(
          hours: hours,
          minutes: minutes,
          seconds: seconds,
          deciseconds: deciseconds,
          date: DateTime.now(),
          checkpoints: locationCheckpoints
        ),
      );
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

Future<void> getLocationPermission() async {
  var _permissionGranted = await Geolocator.checkPermission();

  if (_permissionGranted != LocationPermission.always ||
      _permissionGranted != LocationPermission.whileInUse) {
    await Geolocator.requestPermission();
  }

  if (_permissionGranted != LocationPermission.always ||
      _permissionGranted != LocationPermission.whileInUse) {
    positionGranted = false;
  }
  positionGranted = true;
}
