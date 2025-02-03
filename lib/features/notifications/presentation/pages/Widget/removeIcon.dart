import 'package:flutter/widgets.dart';

class Removeicon extends StatelessWidget {
  const Removeicon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        "x",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w300,
          color: Color(0xff808080),
        ),
      ),
    );
  }
}
