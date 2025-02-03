import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Editandsetting extends StatelessWidget {
  const Editandsetting({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Row(
        children: [
          Container(
            height: 30.h,
            width: 35.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.r),
                bottomLeft: Radius.circular(5.r),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset('assets/icons/edit.svg'),
            ),
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: 30.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                ),
                child: Center(
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 30.h,
              width: 35.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5.r),
                  bottomRight: Radius.circular(5.r),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset('assets/icons/settings.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
