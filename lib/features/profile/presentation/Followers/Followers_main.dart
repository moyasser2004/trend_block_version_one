import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trend/features/profile/data/models/currentUser.dart';
import 'package:trend/features/profile/presentation/Followers/followers_List.dart';
import 'package:trend/features/profile/presentation/Followers/followingList.dart';

class FollowersScreen extends StatefulWidget {
  FollowersScreen({required this.user, required this.index});

  final currentUser user;
  final int index;
  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index = widget.index;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              SizedBox(width: 19.sp),
              SvgPicture.asset(
                "assets/icons/Alt Arrow Left.svg",
                height: 14,
                width: 6,
                fit: BoxFit.none,
              ),
              SizedBox(width: 5.sp),
            ],
          ),
        ),
        title:
            Text(widget.user.username, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          indicatorColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              child: Container(
                child: Text("Followers"),
              ),
            ),
            Tab(text: 'Following'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FollowersList(
            id: widget.user.id,
          ),
          FollowingsList(
            id: widget.user.id,
          )
        ],
      ),
    );
  }
}
