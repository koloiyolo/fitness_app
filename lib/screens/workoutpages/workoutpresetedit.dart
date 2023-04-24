import 'package:fitness_app/imports.dart';

class WorkoutPresetEdit extends StatefulWidget {
  String boxName;
  List<Exercise> presetList;

  WorkoutPresetEdit(
      {required this.boxName, required this.presetList, super.key});

  @override
  State<WorkoutPresetEdit> createState() => _WorkoutPresetEditState();
}

class _WorkoutPresetEditState extends State<WorkoutPresetEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Preset'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: widget.presetList.length,
                      itemBuilder: (context, index) =>
                          ExerciseTile(exercise: widget.presetList[index]))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      if (data.get(widget.boxName) != null) {
                        widget.presetList =
                            exercisesFromList(data.get(widget.boxName));
                      } else {
                        widget.presetList.clear();
                      }

                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.all(24),
                    child: const BuildText(size: 1.5, text: 'Cancel'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      data.put(
                          widget.boxName, exercisesToList(widget.presetList));
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.all(24),
                    child: const BuildText(size: 1.4, text: 'Save Changes'),
                  )
                ],
              )
            ],
          ),
          Positioned(
              right: 16,
              bottom: 80,
              child: FloatingActionButton(
                onPressed: addExercise,
                backgroundColor: Colors.amber[700],
                child: const Icon(Icons.add, size: 40),
              ))
        ],
      ),
    );
  }

  void addExercise() {
    var name = TextEditingController();
    var sets = TextEditingController();
    var reps = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create new exercise'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: name,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            TextFormField(
              controller: sets,
              decoration: const InputDecoration(hintText: 'Sets'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: reps,
              decoration: const InputDecoration(hintText: 'Reps'),
              keyboardType: TextInputType.number,
            ),
            TextButton(
                onPressed: () {
                  if (name.text.isNotEmpty &&
                      sets.text.isNotEmpty &&
                      reps.text.isNotEmpty) {
                    setState(() {
                      widget.presetList.add(Exercise(
                          name: name.text,
                          sets: int.parse(sets.text),
                          reps: int.parse(reps.text),
                          isDone: false));
                      Navigator.pop(context);
                    });
                  }
                },
                child: const BuildText(text: 'Save', size: 1.5))
          ],
        ),
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  Exercise exercise;

  ExerciseTile({
    required this.exercise,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var name = TextEditingController(text: exercise.name);
    var sets = TextEditingController(text: exercise.sets.toString());
    var reps = TextEditingController(text: exercise.reps.toString());
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextFormField(
              controller: name,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextFormField(
              controller: sets,
              decoration: const InputDecoration(hintText: 'Sets'),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TextFormField(
              controller: reps,
              decoration: const InputDecoration(hintText: 'Reps'),
              keyboardType: TextInputType.number,
            ),
          ),
          TextButton(
              onPressed: () {
                exercise.name = name.text;
                exercise.sets = int.parse(sets.text);
                exercise.reps = int.parse(reps.text);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const BuildText(text: 'Changes saved', size: 1.5),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: const BuildText(text: 'Ok', size: 1.5),)
                    ],
                  ),
                );
              },
              child: const BuildText(text: 'Save', size: 1.5))
        ],
      ),
    );
  }
}
