import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:go_do/view_models/home_model.dart';
import 'package:go_do/views/components/main/home_page_column.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColors.primaryColor,
                    elevation: 0,
                    title: const Text(
                      'GoDo',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    centerTitle: true,
                  ),
                  body: model.todayTasks.isNotEmpty
                      ? HomePageColumn()
                      : const Center(
                          child: Text("No tasks scheduled today!"),
                        )),
            ),
        viewModelBuilder: () => HomeModel());
  }
}
