import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:go_do/view_models/category_model.dart';
import 'package:go_do/views/components/main/category_container.dart';
import 'package:go_do/views/components/main/category_expandable_widget.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColors.primaryColor,
                    title: const Text(
                      'My Tasks',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    centerTitle: true,
                    elevation: 0.0,
                  ),
                  body: model.taskBox.isNotEmpty
                      ? Column(
                          children: [
                            CategoryContainer(),
                            const SizedBox(height: 20),
                            CategoryExpandableWidget()
                          ],
                        )
                      : const Center(
                          child: Text("Add tasks to accomplish!"),
                        )),
            ),
        viewModelBuilder: () => CategoryModel());
  }
}
