import 'package:shared_preferences/shared_preferences.dart';
import '../utiles/dependancy_injection.dart';



class token {
  static Future<void> setToken(String t) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", t);
  }

  static Future<void> removeToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("token");
  }

  static String? getToken() {
    return getIt.get<SharedPreferences>().getString("token");
  }
}

bool isloading = false;
