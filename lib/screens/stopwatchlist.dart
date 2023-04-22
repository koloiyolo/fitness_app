import 'package:fitness_app/imports.dart';

class StopWatchList extends StatelessWidget {
  final List<StopWatch> list;
  const StopWatchList({
    required this.list,
    super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24)),
          title: BuildText(
              text:
                  ' ${index + 1}.  ${dateToString(list[index].date)}   ${convMinSecHour(list[index].date.hour)}:${convMinSecHour(list[index].date.minute)}',
              size: 1.7),
          children: [
            const SizedBox(height: 16),
            BuildText(
                text: 'Time: ${list[index].timeToString()}', size: 1.7),
            const SizedBox(height: 16),
            BuildText(
                text: 'Distance: ${sumOfDistance(list[index].checkpoints).round()} m', size: 1.7),
            const SizedBox(height: 16),
            BuildText(
                text: 'Speed: ${((sumOfDistance(list[index].checkpoints)*3.6)/(
                  list[index].seconds 
                  +(60*list[index].minutes) 
                  +(3600*list[index].hours))).toStringAsFixed(2)} km/h', size: 1.7),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
