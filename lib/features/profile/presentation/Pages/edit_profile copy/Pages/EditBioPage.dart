import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_event.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_state.dart';
import 'package:trend/features/profile/presentation/Pages/edit_profile%20copy/Widget/LineLimitInputFormatter.dart';

class Editbiopage extends StatefulWidget {
  const Editbiopage({super.key, required this.bio, required this.userid});
  final int userid;
  final String bio;

  @override
  State<Editbiopage> createState() => _EditbiopageState();
}

class _EditbiopageState extends State<Editbiopage> {
  TextEditingController _controller = TextEditingController();
  String newbio = "";
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) async {
        if (state is Updatesuccess) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString("bio", state.bio);
          BlocProvider.of<ProfileBloc>(context)
              .add(getPostForUserevent(id: widget.userid));
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Edit bio"),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () async {
                if (newbio.isNotEmpty) {
                  BlocProvider.of<ProfileBloc>(context)
                      .add(Updatebio(widget.userid, newbio));
                }
              },
              child: Text("Save"),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            onChanged: (data) {
              setState(() {
                newbio = data;
              });
            },
            maxLength: 80,
            controller: _controller,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xffFAFAFA),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffFAFAFA)),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffFAFAFA)),
              ),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(80),
              LineLimitInputFormatter(3),
            ],
            maxLines: 3,
          ),
        ),
      ),
    );
  }
}
