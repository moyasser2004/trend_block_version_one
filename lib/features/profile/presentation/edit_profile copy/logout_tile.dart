import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trend/features/authentication/presentation/pages/login.dart';
import 'package:trend/features/profile/All_Bloc/bloc/profile_bloc.dart';
import 'package:trend/features/profile/All_Bloc/bloc/profile_event.dart';

class LogoutTile extends StatefulWidget {
  const LogoutTile({Key? key}) : super(key: key);

  @override
  _LogoutTileState createState() => _LogoutTileState();
}

class _LogoutTileState extends State<LogoutTile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      leading: SvgPicture.asset("assets/icons/shape.svg"),
      title: Text(
        "Log Out",
        style: TextStyle(
          color: Colors.red,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: () {
        setState(() {
          isLoading = true;
        });

        BlocProvider.of<ProfileBloc>(context).add(Logout());

        Future.delayed(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        });
      },
    );
  }
}
