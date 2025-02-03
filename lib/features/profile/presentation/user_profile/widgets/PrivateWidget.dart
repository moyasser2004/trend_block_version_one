import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivateWidget extends StatelessWidget {
  const PrivateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 50.h),
        Icon(
          Icons.lock,
          size: 70,
          color: Colors.black,
        ),
        SizedBox(height: 10.h),
        Text(
          "This Account is Private Follow this",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            height: 1.5,
            color: Colors.black,
          ),
        ),
        Text(
          " Account to see his photos",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            height: 1.5,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
