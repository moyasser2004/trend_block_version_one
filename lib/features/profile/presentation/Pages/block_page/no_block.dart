import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoBlock extends StatelessWidget {
  const NoBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Blocked Users',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100.h),
          Center(
            child: Container(
              height: 200,
              width: 200,
              child: Image.asset('assets/icons/block.png'),
            ),
          ),
          SizedBox(height: 10.h),
          Text('No Blocked users!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              'You have not blocked any user yet. Once you block someone, you will see them here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(255, 133, 133, 133),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
