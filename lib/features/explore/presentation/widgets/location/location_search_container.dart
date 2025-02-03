import 'package:flutter/material.dart';

import '../../../../../shared/const/colors.dart';
import '../../../../../shared/style/app_styles.dart';
import '../../../data/models/local/location_details.dart';

class LocationSearchContainer extends StatelessWidget {
  const LocationSearchContainer({Key? key, required this.model})
      : super(key: key);
  final LocationDetails model;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(AppColors.white),
      child: ListTile(
        contentPadding:
            EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        leading: CircleAvatar(
          backgroundColor:Color(AppColors.greyLight) ,
            radius: 24, 
          child: Icon(Icons.location_on_outlined),
        ),
        title: Text(
          model.location_name,
          style: AppStyles.styleBold16,
        ),
        subtitle: Text(
          model.description,
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
