import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_event.dart';
import 'package:trend/features/profile/presentation/Pages/block_page/block.dart';

class blockTile extends StatelessWidget {
  const blockTile({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
          color: Color(0xffF9F9FC),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        leading: Icon(Icons.block, size: 20.sp),
        title: Text("BlockList"),
        trailing: SvgPicture.asset(
          "assets/icons/chevron-small-left.svg",
          height: 20,
          width: 20,
          fit: BoxFit.cover,
        ),
        onTap: () {
          BlocProvider.of<ProfileBloc>(context).add(getBlockedUser(id: id));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BlockedUsers(id: id))); // Navigate to BlockList
        },
      ),
    );
  }
}
