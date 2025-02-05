import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_bloc.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_event.dart';
import 'package:trend/features/profile/presentation/Manager/bloc/profile_state.dart';
import 'package:trend/features/profile/presentation/Pages/edit_profile%20copy/Widget/LineLimitInputFormatter.dart';

class EditFullname extends StatefulWidget {
  const EditFullname({super.key, required this.Fullname, required this.userid});
  final int userid;
  final String Fullname;

  @override
  State<EditFullname> createState() => _EditbiopageState();
}

class _EditbiopageState extends State<EditFullname> {
  TextEditingController _controller = TextEditingController();

  String newfullname = "";
  bool isLoading = false;
  void initState() {
    super.initState();
    // إضافة نص افتراضي
    _controller.text = widget.Fullname;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) async {
        if (state is Updatesuccess) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString("fullName", state.full_name);
          BlocProvider.of<ProfileBloc>(context)
              .add(getPostForUserevent(id: widget.userid));
          Navigator.pop(context);
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading, // عرض شاشة التحميل عند true
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(
          color: Colors.black,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Edit Fullname"),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: () async {
                  if (newfullname.isNotEmpty) {
                    BlocProvider.of<ProfileBloc>(context)
                        .add(Updatefullname(widget.userid, newfullname));
                    setState(() {
                      isLoading = true;
                    });
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
                  newfullname = data;
                });
              },
              maxLength: 30,
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
                LengthLimitingTextInputFormatter(30),
                LineLimitInputFormatter(1),
              ],
              maxLines: 3,
            ),
          ),
        ),
      ),
    );
  }
}
