import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  register() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Semua field wajib diisi')));

      return;
    }

    await AuthService.register(
      usernameController.text,
      passwordController.text,
    );

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Register berhasil')));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            TextField(
              controller: usernameController,

              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: true,

              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: register,
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
