import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  Future<void> saveUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', userName);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<void> removeUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
  }
}

