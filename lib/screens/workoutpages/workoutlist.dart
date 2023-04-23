import 'package:fitness_app/imports.dart';

class WorkoutList extends StatefulWidget {
  const WorkoutList({super.key});

  @override
  State<WorkoutList> createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: today.exercises.length,
              itemBuilder: (context, index) =>
                  workoutListTile(today.exercises[index])),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {
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
                              decoration:
                                  const InputDecoration(hintText: 'Name'),
                            ),
                            TextFormField(
                              controller: sets,
                              decoration:
                                  const InputDecoration(hintText: 'Sets'),
                              keyboardType: TextInputType.number,
                            ),
                            TextFormField(
                              controller: reps,
                              decoration:
                                  const InputDecoration(hintText: 'Reps'),
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
                                    Navigator.pop(context);
                                    exerciseDays.last = today;
                                    data.put('exerciseDays',
                                        exerciseDaysToList(exerciseDays));
                                  });
                                },
                                child: const BuildText(text: 'Save', size: 1.5))
                          ],
                        ),
                      ),
                    );
                  },
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: Colors.amber[700],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        size: 35,
                        color: Color.fromARGB(255, 38, 38, 38),
                      ),
                      Text('A D D',
                          style: TextStyle(
                              color: Color.fromARGB(255, 38, 38, 38),
                              fontSize: 30))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16)
      ],
    );
  }

  Card workoutListTile(Exercise exercise) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Column(
        children: [
          Text(exercise.name,
              style: const TextStyle(fontSize: 25, color: Colors.amber)),
          BuildText(text: 'Sets:  ${exercise.sets}', size: 1.5),
          BuildText(text: 'Reps:  ${exercise.reps}', size: 1.5),
          const SizedBox(height: 24),
          MaterialButton(
            onPressed: () {
              setState(() {
                exercise.isDone = !exercise.isDone;
                data.put('exerciseDays', exerciseDays);
              });
            },
            minWidth: 150,
            color: Colors.amber[700],
            padding: const EdgeInsets.all(8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            // child: exercise.isDone
            // ? Icon(Icons.done_rounded)
            // : Icon(Icons.notdone)
            child: Text(exercise.isDone ? 'Done' : 'Not Done',
                style: const TextStyle(
                    color: Color.fromARGB(255, 38, 38, 38), fontSize: 22)),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
