import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/navigation_model.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:go_do/utils/toast_messages/custom_toast_message.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavigationModel>.reactive(
      viewModelBuilder: () => NavigationModel(),
      builder: (context, viewModel, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            final now = DateTime.now();
            if (viewModel.lastBackPressed == null ||
                now.difference(viewModel.lastBackPressed!) > const Duration(seconds: 2)) {
              viewModel.lastBackPressed = now;
              showToastMessage(
                message: 'Press back again to exit',
                backgroundColor: Colors.black87,
                textColor: Colors.white,
              );
            } else {
              SystemNavigator.pop();
            }
          },
          child: Scaffold(
            extendBody: true,
            body: viewModel.tabs[viewModel.currentIndex],
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: Colors.white),
              ),
              child: CurvedNavigationBar(
                index: viewModel.currentIndex,
                backgroundColor: Colors.transparent,
                color: Colors.black38,
                buttonBackgroundColor: AppColors.primaryColor,
                height: 60,
                onTap: viewModel.setCurrentTab,
                items: viewModel.items,
              ),
            ),
          ),
        );
      },
    );
  }
}
