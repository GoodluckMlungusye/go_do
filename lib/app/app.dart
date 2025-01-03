import 'package:flutter/material.dart';
import '../themes/theme_assets.dart';
import 'package:go_do/views/starters/loader.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoDo App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: AppColors.primaryColor,
        primaryColorDark: AppColors.primaryColorDark,
        primaryColorLight: AppColors.primaryColorLight,
        fontFamily: AppFonts.primaryFont,
      ),
      home: const Loader(),
    );
  }
}
