import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> register(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  static Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');

    if (username == savedUsername && password == savedPassword) {
      await prefs.setBool('isLogin', true);

      return true;
    }

    return false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLogin', false);
  }

  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('username') ?? '';
  }
}
