import 'package:flutter/material.dart';

class Actorandtime extends StatefulWidget {
  const Actorandtime({super.key, required this.Actor, required this.createdAt});
  final String Actor;
  final DateTime createdAt;
  @override
  State<Actorandtime> createState() => _ActorandtimeState();
}

class _ActorandtimeState extends State<Actorandtime> {
  String getTimeAgoShort(DateTime createdAt) {
    final currentTime = DateTime.now();
    final difference = currentTime.difference(createdAt);

    if (difference.inDays > 0) {
      return '${difference.inDays}d'; // e.g. "1 d"
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h'; // e.g. "5 h"
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m'; // e.g. "10 m"
    } else {
      return '${difference.inSeconds}s'; // e.g. "30 s"
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.Actor, // Dynamic actor name
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "${getTimeAgoShort(widget.createdAt)}",
          style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Color(
                  0xff999EB2)), // Replace with dynamic timestamp if available
        ),
      ],
    );
  }
}
