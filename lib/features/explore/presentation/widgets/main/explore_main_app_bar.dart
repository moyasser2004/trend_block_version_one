import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trend/shared/style/app_styles.dart';
import 'package:trend/shared/utiles/routes.dart';

import '../../../../../shared/const/colors.dart';
import '../../../../../shared/utiles/services_local.dart';
import '../../manager/for_you/for_you_search_bloc.dart';
import '../../manager/hashtags/hashtags_bloc.dart';
import '../../manager/location/location_bloc.dart';
import '../../pages/explore_search.dart';
import '../../pages/on_change_search.dart';

class ExploreMainAppBarContainer extends StatelessWidget
    implements PreferredSizeWidget {
  const ExploreMainAppBarContainer({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InkWell(
        onTap: () {
          
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation,
                    secondaryAnimation) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (_) =>
                            ForYouSearchBloc(
                              searchExploreUseCase:
                              sl(),
                              userSearchUseCase:
                              sl(),
                            )),
                  ],
                  child: OnChangeSearch()
                ),
                transitionDuration: Duration(
                    milliseconds:
                    0), // No transition
              ));
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          child: Row(
            children: [
              // Back Button
              Flexible(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: IconButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pushNamed(context, AppRoutes.home);
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.userFriends,
                      size: 28,
                      color: Color(AppColors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 7),
              // Basic Container for Search (instead of TextFormField)
              Expanded(
                flex: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10, vertical: 9),
                  decoration: BoxDecoration(
                    color:
                        Color(AppColors.greyLighter).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      Icon(
                        FontAwesomeIcons.search,
                        size: 16,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '  Search',
                        style: AppStyles.styleNormal13.copyWith(
                          color: Color(AppColors.greyDark),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
