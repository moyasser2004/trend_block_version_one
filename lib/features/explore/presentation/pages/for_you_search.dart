import 'package:flutter/cupertino.dart';
import '../../../../shared/const/colors.dart';
import '../../../../shared/const/const.dart';
import '../../../../shared/style/app_styles.dart';
import '../widgets/for_you/explore_list_search_users.dart';
import '../widgets/for_you/explore_search_for_you_post.dart';

class ExploreSearchForYou extends StatelessWidget {
  const ExploreSearchForYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 14.0, left: 12.0, right: 12.0, bottom: 10.0),
            child: Text(
              accounts,
              style: AppStyles.styleNormal16
                  .copyWith(color: Color(AppColors.black)),
            ),
          ),
        ),

        // for you search users
        ExploreListSearch(),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 14.0, left: 12.0, right: 12.0, bottom: 7.0),
            child: Text(
              explorePost,
              style: AppStyles.styleNormal16
                  .copyWith(color: Color(AppColors.black)),
            ),
          ),
        ),

        // for you search post
        ExploreSearchForYouPost()
      ],
    );
  }
}
