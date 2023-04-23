import 'package:fitness_app/imports.dart';
import 'package:barcode_widget/barcode_widget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  DateTime date = DateTime.parse(user.get('date'));

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32)
        ),
        child: Wrap(
          children: [
            Center(
          child: Image.asset(
        'lib/assets/user.gif',
        height: 250,
      )),
      Padding(
        padding: const EdgeInsets.only(left: 24),
        child: BuildText(text: 'Name: ${user.get('name')}', size: 1.8),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 24),
        child: BuildText(text: 'Surname: ${user.get('surname')}', size: 1.8),
      ),
      Padding(
        padding: const EdgeInsets.all(24),
        child: BuildText(text: 'Joined: ${dateToString(date)}', size: 1.3),
      ),
          ],
        ),
      ),
     
      const Expanded(child: SizedBox()),
      (user.get('hasCard'))
          ? Padding(
              padding: const EdgeInsets.all(45),
              child: MaterialButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          'Your gym card',
                          style: TextStyle(color: Colors.black),
                        ),
                        content: BarcodeWidget(
                          barcode: Barcode.itf(),
                          data: '005449',
                          height: 250,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok', style: TextStyle(fontSize: 20, color: Colors.black)),
                          ),
                        ],
                      ),
                    );
                  },
                  color: Colors.amber[800],
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(24)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.card_membership_rounded, size: 50),
                      BuildText(text: ' Show gym card', size: 2)
                    ],
                  )),
            )
          : Padding(
              padding: const EdgeInsets.all(45),
              child: MaterialButton(
                  onPressed: () {
                    var barcode = TextEditingController();
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('Input your card barcode'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                      'To get your card barcode you can scan your gym card barcode with Google Lens'),
                                  TextFormField(
                                    controller: barcode,
                                    decoration: const InputDecoration(
                                        hintText: 'Your card barcode'),
                                  )
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const BuildText(
                                      text: 'Cancel', size: 1.2),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (barcode.text.isNotEmpty) {
                                      setState(() {
                                        user.put('hasCard', true);
                                        user.put('cardBarCode', barcode.text);
                                        Navigator.pop(context);
                                      });
                                    }
                                  },
                                  child: const BuildText(text: 'Ok', size: 1.2),
                                )
                              ],
                            ));
                  },
                  color: Colors.amber[800],
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(24)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add_circle_outline_rounded, size: 50),
                      BuildText(text: ' Add gym card', size: 2)
                    ],
                  )),
            )
    ]);
  }
}
