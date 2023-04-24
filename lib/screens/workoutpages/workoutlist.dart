import 'package:fitness_app/imports.dart';

class WorkoutList extends StatefulWidget {
  const WorkoutList({super.key});

  @override
  State<WorkoutList> createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: today.exercises.length,
          itemBuilder: (context, index) =>
              workoutListTile(today.exercises[index]),
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton(
            onPressed: addExercise,
            backgroundColor: Colors.amber[700],
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.add,
                  size: 40,
                  color: Color.fromARGB(255, 38, 38, 38),
                ),
                // Text('   A D D',
                //     style: TextStyle(
                //         color: Color.fromARGB(255, 38, 38, 38),
                //         fontSize: 30))
              ],
            ),
          ),
        ),
        const SizedBox(height: 16)
      ],
    );
  }

  Widget workoutListTile(Exercise exercise) {
    /// edit button function
    void editExercise() {
      var sets = TextEditingController(text: exercise.sets.toString());
      var reps = TextEditingController(text: exercise.reps.toString());

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const BuildText(text: 'Edit exercise', size: 1.5),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: sets,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'sets'),
              ),
              TextFormField(
                controller: reps,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'reps'),
              )
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const BuildText(text: 'Cancel', size: 1.5)),
            TextButton(
                onPressed: () {
                  setState(() {
                    if (sets.text.isNotEmpty) {
                      exercise.sets = int.parse(sets.text);
                    }
                    if (reps.text.isNotEmpty) {
                      exercise.sets = int.parse(sets.text);
                    }
                    data.put('today', today.toList());
                    Navigator.pop(context);
                  });
                },
                child: const BuildText(text: 'Save', size: 1.5))
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Column(
          children: [
            Text(exercise.name,
                style: const TextStyle(fontSize: 25, color: Colors.amber)),
            BuildText(text: 'Sets:  ${exercise.sets}', size: 1.2),
            BuildText(text: 'Reps:  ${exercise.reps}', size: 1.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: editExercise,
                  minWidth: 150,
                  color: Colors.amber[700],
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: const Text('Edit',
                      style: TextStyle(
                          color: Color.fromARGB(255, 38, 38, 38),
                          fontSize: 20)),
                ),
                const SizedBox(width: 8),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      exercise.isDone = !exercise.isDone;
                      data.put('today', today.toList());
                    });
                  },
                  minWidth: 150,
                  color: Colors.amber[700],
                  padding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  // child: exercise.isDone
                  // ? Icon(Icons.done_rounded)
                  // : Icon(Icons.notdone)
                  child: Text(exercise.isDone ? 'Done' : 'Not Done',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 38, 38, 38),
                          fontSize: 20)),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
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
        title: const Text('Add new exercise'),
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
                  setState(() {
                    today.exercises.add(Exercise(
                        name: name.text,
                        sets: int.parse(sets.text),
                        reps: int.parse(reps.text),
                        isDone: false));
                    data.put('today', today.toList());
                    Navigator.pop(context);
                  });
                },
                child: const BuildText(text: 'Save', size: 1.5))
          ],
        ),
      ),
    );
  }
}
