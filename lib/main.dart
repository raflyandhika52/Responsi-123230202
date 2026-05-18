import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool('isLogin') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsi PAM',
      theme: newMethod(),
      home: FutureBuilder<bool>(
        future: checkLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text(
                  'Gagal membaca status login. Silakan coba lagi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          }

          final bool isLogin = snapshot.data ?? false;

          if (isLogin) {
            return const HomePage();
          }

          return const LoginPage();
        },
      ),
    );
  }

  ThemeData newMethod() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      scaffoldBackgroundColor: Colors.grey[50],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
      ),
    );
  }
}
