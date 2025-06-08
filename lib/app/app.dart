import 'package:flutter/material.dart';
import '../themes/theme_assets.dart';
import 'package:go_do/views/starters/splash_screen.dart';
import 'package:go_do/views/tabs/categories.dart';
import 'package:go_do/views/tabs/home.dart';
import 'package:go_do/views/tabs/add_option.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoDo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: AppColors.primaryColor,
        primaryColorDark: AppColors.primaryColorDark,
        primaryColorLight: AppColors.primaryColorLight,
        fontFamily: AppFonts.primaryFont,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/categories': (context) => CategoriesPage(),
        '/home': (context) => HomePage(),
        '/options': (context) => AddOptionPage(),
      },
    );
  }
}
