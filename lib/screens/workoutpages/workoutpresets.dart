import 'package:fitness_app/imports.dart';
import 'package:fitness_app/screens/workoutpages/workoutpresetedit.dart';

class WorkoutPresetsPage extends StatefulWidget {
  const WorkoutPresetsPage({super.key});

  @override
  State<WorkoutPresetsPage> createState() => _WorkoutPresetsPageState();
}

class _WorkoutPresetsPageState extends State<WorkoutPresetsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        listTile('Monday', monday, 'monday'),
        listTile('Tuesday', tuesday, 'tuesday'),
        listTile('Wednesday', wednesday, 'wednesday'),
        listTile('Thursday', thursday, 'thursday'),
        listTile('Friday', friday, 'friday'),
        listTile('Saturday', saturday, 'saturday'),
        listTile('Sunday', sunday, 'sunday'),
      ],
    );
  }

  Widget listTile(String weekday, List<Exercise> presetList, String boxName) {
    return Column(
      children: [
        ExpansionTile(
          backgroundColor: const Color.fromARGB(255, 70, 70, 70),
          title: BuildText(text: weekday, size: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          children: [
            const BuildText(text: 'Exercises:', size: 1.4),
            ListView.builder(
              shrinkWrap: true,
              itemCount: presetList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: BuildText(
                    text: '${index + 1}. ${presetList[index].name}', size: 1.4),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WorkoutPresetEdit(
                                  presetList: presetList,
                                  boxName: weekday.toLowerCase(),
                                )));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  child: const BuildText(text: 'Edit', size: 1.2),
                ),
                MaterialButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Are you sure'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const BuildText(text: 'No', size: 1.2)),
                          TextButton(
                              onPressed: () {
                                presetList.clear();
                                data.delete(boxName);
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                              child: const BuildText(text: 'Yes', size: 1.2))
                        ],
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  child: const BuildText(text: 'Delete', size: 1.2),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 16)
      ],
    );
  }
}
