import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../shared/const/colors.dart';
import '../../../../../shared/style/app_styles.dart';
import '../../../data/models/local/hashtags_details.dart';

class HashtagsContainer extends StatelessWidget {
  const HashtagsContainer({Key? key, required this.model}) : super(key: key);

  final HashtagsDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(AppColors.white),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        leading: CircleAvatar(
          backgroundColor: Color(AppColors.greyLight),
          radius: 24,
          child: Icon(
            FontAwesomeIcons.hashtag,
            color: Color(AppColors.greyDark),
          ),
        ),
        title: Text(
          model.author,
          style: AppStyles.styleBold16,
        ),
        subtitle: Text(
          model.posts_count,
          style: AppStyles.styleNormal11.copyWith(
              color: Color(
            AppColors.greyDark,
          )),
        ),
        trailing: Text(
          formatCreatedAt(model.created_at),
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

  String formatCreatedAt(String createdAt) {
    // Parse the string to DateTime
    DateTime dateTime = DateTime.parse(createdAt);

    // Extract the day, month, year, hour, and minute
    String formattedDate =
        '${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    return formattedDate;
  }
}
