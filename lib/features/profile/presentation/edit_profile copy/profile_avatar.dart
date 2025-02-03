import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trend/features/posts/presentation/widgets/Networkimage.dart';

class ProfileAvatar extends StatefulWidget {
  final String avatarUrl;
  final File? selectedImage;
  final VoidCallback pickImageFromCamera;
  final VoidCallback pickImage;
  final void Function()? onTap;
  const ProfileAvatar({
    Key? key,
    required this.avatarUrl,
    required this.selectedImage,
    required this.pickImageFromCamera,
    required this.pickImage,
    this.onTap,
  }) : super(key: key);

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        GestureDetector(
            onLongPress: widget.onTap,
            child: Networkimages(
              imageUrl: widget.avatarUrl.startsWith('http')
                  ? widget.avatarUrl
                  : 'http://167.71.92.176${widget.avatarUrl}',
              size: 56,
            )),
        Positioned(
          bottom: 3.sp,
          left: 0.sp,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return FractionallySizedBox(
                    heightFactor: 0.3,
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Text(
                          'Choose Image Source',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.camera,
                                size: 30,
                                color: Colors.black,
                              ),
                              onPressed: () async {
                                widget.pickImageFromCamera();
                                setState(() {});
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(width: 20),
                            IconButton(
                              icon: Icon(
                                Icons.image,
                                size: 30,
                                color: Colors.blue,
                              ),
                              onPressed: () async {
                                widget.pickImage();
                                setState(() {});
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 5,
                          width: 134,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: CircleAvatar(
              radius: 12.sp,
              backgroundColor: Colors.white,
              child: SvgPicture.asset(
                "assets/icons/EditIcon.svg",
                height: 20,
                width: 20,
                fit: BoxFit.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
