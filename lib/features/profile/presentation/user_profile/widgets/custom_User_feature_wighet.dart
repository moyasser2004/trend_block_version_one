import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomUserFeatureWighet extends StatelessWidget {
  const CustomUserFeatureWighet(
      {super.key, required this.number, required this.name});
  final String number;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${number}',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
