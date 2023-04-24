import 'package:fitness_app/appdrawer.dart';
import 'package:fitness_app/imports.dart';
import 'package:fitness_app/objects/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

enum Gender { male, female }

Gender? gender;
final name = TextEditingController();
final surname = TextEditingController();
// final age = TextEditingController();
// final height = TextEditingController();
// final weight = TextEditingController();

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 48),
            const Text(
              'Heyyyy',
              style: TextStyle(
                fontSize: 45,
                color: Colors.amber,
              ),
            ),
            Image.asset('lib/assets/bear.gif', scale: 1),
            const BuildText(text: 'Tell us something about you', size: 1.8),
            const SizedBox(height: 16),
            TextFormField(
              controller: name,
              style: const TextStyle(fontSize: 25),
              decoration: const InputDecoration(hintText: 'Your name'),
            ),
            TextFormField(
              controller: surname,
              style: const TextStyle(fontSize: 25),
              decoration: const InputDecoration(hintText: 'Your surname'),
            ),

            /// TextFormFields may be useful later
            // TextFormField(
            //   controller: age,
            //   style: const TextStyle(fontSize: 25),
            //   keyboardType: TextInputType.number,
            //   decoration: const InputDecoration(hintText: 'Your age'),
            // ),
            // TextFormField(
            //   controller: height,
            //   style: const TextStyle(fontSize: 25),
            //   keyboardType: TextInputType.number,
            //   decoration: const InputDecoration(hintText: 'Your height in cm'),
            // ),
            // TextFormField(
            //   controller: weight,
            //   style: const TextStyle(fontSize: 25),
            //   keyboardType: TextInputType.number,
            //   decoration: const InputDecoration(hintText: 'Your weight in kg'),
            // ),
            // const SizedBox(height: 16),
            // const Center(child: BuildText(text: 'Your sex: ', size: 1.5)),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     RadioMenuButton<Gender>(
            //         value: Gender.male,
            //         groupValue: gender,
            //         onChanged: (value) {
            //           setState(() {
            //             gender = value;
            //           });
            //         },
            //         child: const BuildText(text: 'Male', size: 1.5)),
            //     RadioMenuButton<Gender>(
            //         value: Gender.female,
            //         groupValue: gender,
            //         onChanged: (value) {
            //           setState(() {
            //             gender = value;
            //           });
            //           gender = Gender.female;
            //         },
            //         child: const BuildText(text: 'Female', size: 1.5)),
            //   ],
            // ),

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: MaterialButton(
                    onPressed: () {
                      if (name.text.isEmpty || surname.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Empty fields'),
                                  content: const BuildText(
                                      text: 'Please fill all missing fields',
                                      size: 1.3),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const BuildText(
                                            text: 'Ok', size: 1.3))
                                  ],
                                ));
                      } else {
                        createUser(name.text, surname.text, DateTime.now());

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((_) => const AppDrawer())));
                      }

                      ///may be usefull later

                      // if (name.text.isNotEmpty &&
                      //     age.text.isNotEmpty &&
                      //     height.text.isNotEmpty &&
                      //     weight.text.isNotEmpty) {
                      //   createUser(
                      //       name.text,
                      //       int.parse(age.text),
                      //       int.parse(height.text),
                      //       double.parse(weight.text),
                      //       (gender == Gender.male) ? 'male' : 'female',
                      //       DateTime.now());

                      //   Navigator.pushReplacement(context,
                      //       MaterialPageRoute(builder: ((_) => const AppDrawer())));
                      // } else {
                      //   showDialog(
                      //       context: context,
                      //       builder: ((context) => AlertDialog(
                      //             title: const Text('Empty fields'),
                      //             content: const BuildText(
                      //                 text: 'Please fill all missing fields',
                      //                 size: 1.3),
                      //             actions: [
                      //               TextButton(
                      //                   onPressed: () {
                      //                     Navigator.pop(context);
                      //                   },
                      //                   child: const BuildText(
                      //                       text: 'Ok', size: 1.3))
                      //             ],
                      //           )));
                      // }
                    },
                    visualDensity: VisualDensity.comfortable,
                    padding: const EdgeInsets.all(21),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.amber[700],
                    child: const BuildText(
                      text: 'Create User',
                      size: 1.8,
                    )),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
