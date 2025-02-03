import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget GetIconForNotification(String x) {
  if (x.contains("liked your")) {
    return SvgPicture.asset(
      "assets/icons/like_fill.svg",
      height: 15,
      width: 15,
      fit: BoxFit.fill,
    );
  } else if (x.contains("replied to your comment") ||
      x.contains("commented on")) {
    return SvgPicture.asset(
      "assets/icons/NotificationComment.svg",
      height: 15,
      width: 15,
      fit: BoxFit.fill,
    );
  } else {
    return Text("");
  }
}
