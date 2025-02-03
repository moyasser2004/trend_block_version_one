import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../shared/utiles/profile_helper.dart';

class DeleteTile extends StatelessWidget {
  const DeleteTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Color(0xffF9F9FC),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        trailing: Text(
          "Delete",
          style: TextStyle(
              color: Colors.red, fontSize: 15, fontWeight: FontWeight.w400),
        ),
        leading: SvgPicture.asset("assets/icons/Delete.svg"),
        title: Text(
          "Delete Account",
          style: TextStyle(
              color: Color(0xff212121),
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
        onTap: () {
          ProfileHelper.showDeleteDialog(context);
        },
      ),
    );
  }
}
