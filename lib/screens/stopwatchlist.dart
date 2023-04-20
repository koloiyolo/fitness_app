import 'package:fitness_app/imports.dart';


class StopWatchList extends StatelessWidget {
  const StopWatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stopWatchList.length,
      itemBuilder: (context, 
      index) => ExpansionTile(
        title: BuildText(text:' ${index+1}.  ${dateToString(stopWatchList[index].date)}   ${
        stopWatchList[index].date.hour}:${stopWatchList[index].date.minute}' ,size: 1.7),
        children: [
          const SizedBox(height: 16),
          BuildText(text: 'Time: ${stopWatchList[index].timeToString()}', size: 1.7),
          const SizedBox(height: 16),
        ],
        ),);
  }
}


