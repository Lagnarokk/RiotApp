import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'user_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userNameController = TextEditingController();

  void _login() async {
    final userName = _userNameController.text;
    if (userName.isNotEmpty) {
      await UserStorageService().saveUserData('userName', userName);
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/icons/titleIcon.svg',
                width: 150, // Adjust the size as needed
                height: 150, // Adjust the size as needed
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _userNameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
