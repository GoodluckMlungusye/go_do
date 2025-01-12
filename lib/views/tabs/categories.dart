import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/category_model.dart';
import 'package:go_do/views/components/main/category_container.dart';
import 'package:go_do/views/components/main/category_expandable_widget.dart';
import 'package:go_do/services/service_injector/dependency_container.dart';
import 'package:go_do/services/ui_service.dart';

class CategoriesPage extends StatelessWidget {
  CategoriesPage({super.key});
  final _uiService = locator.get<UiService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryModel>.reactive(
        builder: (context, model, child) => SafeArea(
              child: Scaffold(
                  appBar: _uiService.getAppBar('My Tasks'),
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
