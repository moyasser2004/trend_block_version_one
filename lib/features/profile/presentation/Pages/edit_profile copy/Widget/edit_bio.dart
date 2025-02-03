import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ProfileEdiable { fullName, bio }

class EditBio extends StatefulWidget {
  final ProfileEdiable profileEdiable;
  final int lineCount;
  final int charsCount;
  final String title;
  final String value;

  const EditBio({
    required this.profileEdiable,
    required this.lineCount,
    required this.charsCount,
    required this.title,
    required this.value,
  });

  @override
  State<EditBio> createState() => _EditBioState();
}

class _EditBioState extends State<EditBio> {
  late TextEditingController _bioController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _bioController = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a delay for saving the profile
    await Future.delayed(Duration(seconds: 2));

    log('Profile saved with value: ${_bioController.text}');

    setState(() {
      _isLoading = false;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(
                height: 60.sp,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20.sp,
                        ),
                        Text(
                          "Cancel",
                        ),
                        SizedBox(
                          width: 20.sp,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                    onPressed: _saveProfile,
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
              Divider(color: const Color.fromARGB(255, 243, 243, 243)),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    onChanged: (text) {
                      // Dynamically limit the number of lines
                      final lines = text.split('\n');
                      if (lines.length > widget.lineCount) {
                        _bioController.text =
                            lines.take(widget.lineCount).join('\n');
                        _bioController.selection = TextSelection.fromPosition(
                            TextPosition(offset: _bioController.text.length));
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(widget.charsCount),
                    ],
                    controller: _bioController,
                    maxLines: widget.lineCount,
                    maxLength: widget.charsCount,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.4))),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.4)))),
                  ))
            ],
          ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}
