import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final SharedPreferences sharedPreferences;

  SharedPrefs({required this.sharedPreferences});
  Future<void> saveUserName(String userName) async {
    await sharedPreferences.setString('userName', userName);
  }

  Future<String?> getUserName() async {
    return sharedPreferences.getString('userName');
  }

  Future<void> clearAll() async {
    await sharedPreferences.clear();
  }
}
