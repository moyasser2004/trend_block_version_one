import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/features/profile/data/models/currentUser.dart';

class Mynameandavatar extends StatelessWidget {
  const Mynameandavatar(
      {super.key, required this.onLongPress, required this.user});
  final void Function()? onLongPress;
  final currentUser user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onLongPress: onLongPress,
          child: CircleAvatar(
            radius: 50.r, // تحديد الحجم
            backgroundColor: Colors.white, // لون الخلفية (اختياري)
            backgroundImage: NetworkImage(
              user.avatar.startsWith('http')
                  ? user.avatar // إذا كانت الصورة تحتوي بالفعل على URL كامل
                  : 'http://167.71.92.176${user.avatar}',
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the text horizontally
          children: [
            Text(
              user.username,
              style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(width: 3.w),
            Icon(
              Icons.verified,
              size: 12.h,
              color: Colors.blue,
            ),
          ],
        ),
      ],
    );
    ;
  }
}
