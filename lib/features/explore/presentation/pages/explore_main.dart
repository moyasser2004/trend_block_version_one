import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trend/features/explore/presentation/manager/explore/explore_bloc.dart';
import 'package:trend/shared/const/colors.dart';
import 'package:trend/shared/style/app_styles.dart';

import '../../../../shared/const/const.dart';
import '../../../../shared/utiles/routes.dart';
import '../../../../shared/utiles/services_local.dart';
import '../widgets/main/explore_main_app_bar.dart';
import '../widgets/main/explore_post_grid.dart';

class ExploreMainPage extends StatelessWidget {
  const ExploreMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ExploreBloc>(),
      child: WillPopScope(
        onWillPop: () {
          Navigator.pushNamed(context, AppRoutes.home);
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: Color(AppColors.white),
          appBar: ExploreMainAppBarContainer(),
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 14.0, left: 12.0, right: 12.0, bottom: 10.0),
                child: Text(
                  explorePost,
                  style: AppStyles.styleNormal16
                      .copyWith(color: Color(AppColors.black)),
                ),
              ),
              // explore post grid
              Expanded(child: ExplorePostGrid())
            ],
          )),
        ),
      ),
    );
  }
}
