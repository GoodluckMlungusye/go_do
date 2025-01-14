import 'package:flutter/material.dart';
import 'package:go_do/models/Category.dart';
import 'package:go_do/view_models/category_model.dart';
import 'package:go_do/views/pages/tasks.dart';
import 'package:go_do/utils/toast_messages/error_toast_message.dart';
import 'package:go_do/views/components/child/category_gesture_detector_column.dart';

class CategoryGestureDetector extends StatelessWidget {
  final CategoryModel model;
  final Category category;
  final int totalCategoryTasks;
  const CategoryGestureDetector(
      {super.key, required this.category, required this.totalCategoryTasks, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        totalCategoryTasks < 1
            ? showErrorToastMessage('No tasks')
            : Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                TasksPage(taskCategory: category.name)));
      },
      child: SizedBox(
        height: 50,
        width: 50,
        child: Card(
            elevation: 8,
            child: Padding(
              padding:
              const EdgeInsets.only(top: 28, right: 10, left: 10),
              child: CategoryGestureDetectorColumn(model: model, category: category),
            )),
      ),
    );
  }
}
