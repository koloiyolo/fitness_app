import 'package:fitness_app/imports.dart';

class StopWatchList extends StatelessWidget {
  final List<StopWatch> list;
  const StopWatchList({
    required this.list,
    super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: runningList.length,
      itemBuilder: (context, index) => ExpansionTile(
        title: BuildText(
            text:
                ' ${index + 1}.  ${dateToString(runningList[index].date)}   ${convMinSecHour(runningList[index].date.hour)}:${convMinSecHour(runningList[index].date.minute)}',
            size: 1.7),
        children: [
          const SizedBox(height: 16),
          BuildText(
              text: 'Time: ${runningList[index].timeToString()}', size: 1.7),
          const SizedBox(height: 16),
          BuildText(
              text: 'Distance: ${sumOfDistance(runningList[index].checkpoints).round()} m', size: 1.7),
          const SizedBox(height: 16),
          BuildText(
              text: 'Speed: ${((sumOfDistance(runningList[index].checkpoints)*3.6)/(
                runningList[index].seconds 
                +(60*runningList[index].minutes) 
                +(3600*runningList[index].hours))).toStringAsFixed(2)} km/h', size: 1.7),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
