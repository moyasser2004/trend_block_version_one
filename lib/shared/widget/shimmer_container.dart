import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trend/shared/const/colors.dart';




class CustomerShimmerContainer extends StatelessWidget {
  const CustomerShimmerContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(AppColors.grey),
      highlightColor: Color(AppColors.greyLight),
      child: Container(
        decoration: BoxDecoration(
          color: Color(AppColors.greyDark),
          borderRadius: BorderRadius.circular(12),
        ),
      )
      ,);
  }
}