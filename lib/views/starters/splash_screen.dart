import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:go_do/views/starters/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const WelcomePage()),
    );
  }

  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'GoDo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
