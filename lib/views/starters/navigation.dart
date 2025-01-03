import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/navigation_model.dart';
import 'package:go_do/themes/theme_assets.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                extendBody: true,
                body: model.tabs[model.currentIndex],
                bottomNavigationBar: Theme(
                  data: Theme.of(context).copyWith(
                      iconTheme: const IconThemeData(color: Colors.white)),
                  child: CurvedNavigationBar(
                    index: model.currentIndex,
                    backgroundColor: Colors.transparent,
                    color: Colors.black38,
                    buttonBackgroundColor: AppColors.primaryColor,
                    height: 60,
                    onTap: (index) {
                      model.setCurrentTab(index);
                    },
                    items: model.items,
                  ),
                ),
              ),
            ),
        viewModelBuilder: () => NavigationModel());
  }
}
