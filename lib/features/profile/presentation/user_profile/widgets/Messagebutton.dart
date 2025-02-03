import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Messagebutton extends StatelessWidget {
  const Messagebutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145.w,
      height: 28.h,
      child: Expanded(
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.r),
            ),
            side: BorderSide.none, // Remove the border
          ),
          child: Text(
            'Message',
            style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 12.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
