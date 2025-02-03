import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextFiledForComment extends StatefulWidget {
  const CustomTextFiledForComment(
      {super.key,
      required this.onChanged,
      required this.controller,
      required this.onTap});
  final void Function(String) onChanged;
  final TextEditingController controller;
  final void Function() onTap;
  @override
  State<CustomTextFiledForComment> createState() =>
      _CustomTextFiledForCommentState();
}

class _CustomTextFiledForCommentState extends State<CustomTextFiledForComment> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: "Add Comment...",
        hintStyle: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey[400],
        ),
        fillColor: Color(0xffF9F9FC),
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(100)),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 16.w,
        ),
        suffixIcon: SizedBox(
          height: 15,
          child: GestureDetector(
              onTap: widget.onTap,
              child: SvgPicture.asset(
                "assets/icons/button.svg", // تأكد من أن الملف بصيغة SVG
                fit: BoxFit.none,
                height: 36,
                width: 36,
              )),
        ),
      ),
      style: TextStyle(
        fontSize: 12.sp,
      ),
    );
  }
}
