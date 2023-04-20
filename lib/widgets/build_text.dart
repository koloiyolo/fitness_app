import '../imports.dart';

class BuildText extends StatelessWidget {
  final String text;
  final double size;
  const BuildText({
    required this.text,
    required this.size,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(
      fontSize: 15*size
    ),
      
    );
  }
}