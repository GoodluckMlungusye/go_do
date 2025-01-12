import 'package:flutter/material.dart';
import 'package:go_do/themes/theme_assets.dart';

class UiService{

  PreferredSizeWidget? getAppBar(String title){
    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
    );
  }
}