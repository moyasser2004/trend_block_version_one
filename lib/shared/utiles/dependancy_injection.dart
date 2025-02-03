import 'package:dio/dio.dart';
import 'package:dio_intercept_to_curl/dio_intercept_to_curl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trend/shared/core/local/SharedPreferencesDemo.dart';

import '../core/shared_preferences.dart';


GetIt getIt = GetIt.instance;

class DependancyInjection {
  static DependancyInjection dependancyInjection =
  DependancyInjection();

  initDependancies() async {
    await initSharedPrefrences();
    initDio();
  }

  initSharedPrefrences() async {
    SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    SharedPreferencesDemo sharedPreferencesDemo =
    SharedPreferencesDemo();
    getIt.registerLazySingleton<SharedPreferences>(() {
      return sharedPreferences;
    });
    getIt.registerLazySingleton<SharedPreferencesDemo>(() {
      return sharedPreferencesDemo;
    });
  }

  initDio() {
    getIt.registerLazySingleton<Dio>(() {
      final Dio dio = Dio();
      dio.interceptors.add(DioInterceptToCurl(printOnSuccess: true));
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
      dio.options.headers["Authorization"] = token.getToken() == null
          ? null
          : ("Bearer ${token.getToken()}");

      return dio;
    });
  }
}

