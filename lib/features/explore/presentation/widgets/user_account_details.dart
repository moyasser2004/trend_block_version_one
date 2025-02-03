import 'package:flutter/material.dart';

import '../../../../shared/const/colors.dart';
import '../../../../shared/style/app_styles.dart';
import '../../data/models/local/user_details_model.dart';

class UserAccountDetails extends StatelessWidget {
  const UserAccountDetails({Key? key, required this.model})
      : super(key: key);
  final UserDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(AppColors.white),
      child: ListTile(
        contentPadding:
            EdgeInsets.symmetric(horizontal: 13, vertical: 9),
        leading:
            CircleAvatar(radius: 28, backgroundImage: NetworkImage(model.avatar),backgroundColor: Colors.transparent,),
        title: Text(
          model.username,
          style: AppStyles.styleBold16,
        ),
        subtitle: Text(
          model.full_name,
          style: AppStyles.styleNormal11.copyWith(
              color: Color(
            AppColors.greyDark,
          )),
        ),
        horizontalTitleGap: 14,
        minTileHeight: 60,
        onTap: () {
          // Handle item tap
        },
      ),
    );
  }
}
