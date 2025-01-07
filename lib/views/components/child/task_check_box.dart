import 'package:go_do/models/Task.dart';
import 'package:go_do/views/pages/tasks.dart';
import 'package:flutter/material.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/task_model.dart';

class TaskCheckBox extends StatelessWidget {
  final Task task;
  const TaskCheckBox(
      {super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskModel>.reactive(
        builder: (context, model, child) {
          return Checkbox(
              activeColor: AppColors.primaryColorLight,
              side: const BorderSide(color: AppColors.primaryColorLight),
              value: task.isFinished,
              onChanged: (newBool) {
                model.handleCheckBoxChange(newBool, task);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => TasksPage(
                        taskCategory:
                            model.categoryBox.getAt(task.categoryKey)!.name)));
              });
        },
        viewModelBuilder: () => TaskModel());
  }
}
