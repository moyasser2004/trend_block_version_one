import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:trend/shared/utiles/bloc_providers.dart';
import 'package:trend/shared/utiles/dependancy_injection.dart';
import 'package:trend/shared/utiles/routes.dart';
import 'package:trend/shared/utiles/services_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependancyInjection.dependancyInjection.initDependancies();
  ServiceLocator().init();
  PhotoManager.setIgnorePermissionCheck(false);
  runApp(
    AppBlocProviders.getBlocProviders(
      child: const MyApp(),
    ),
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder:
    //       // (context)=>  MyApp(),
    //       (context) => AppBlocProviders.getBlocProviders(
    //     child: const MyApp(),
    //   ), // Wrap your app
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          // useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          color: Colors.white,
          themeMode: ThemeMode.light,
          title: 'Trend',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.login,
          routes: routes,
          // Ensure routes are defined in utils/routes.dart
          onGenerateRoute: onGenerateRoute, // Handle dynamic routing
        );
      },
    );
  }
}
