import '../imports.dart';

class BuildTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final double size;
  const BuildTextFormField({
    required this.size,
    required this.controller,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        controller: controller,
        style: TextStyle(
        fontSize: 15*size
      ),
      ),
    );
  }
}