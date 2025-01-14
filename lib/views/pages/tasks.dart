import 'package:flutter/material.dart';
import 'package:go_do/views/starters/navigation.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/task_model.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:go_do/views/components/main/tasks_column.dart';

class TasksPage extends StatelessWidget {
  final String taskCategory;
  const TasksPage({super.key, required this.taskCategory});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskModel>.reactive(
        onViewModelReady: (model) => model.initialize(taskCategory),
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const Navigation()));
                      },
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
                  backgroundColor: AppColors.primaryColor,
                  elevation: 0,
                  title: Text(
                    taskCategory,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  centerTitle: true,
                ),
                body: TasksColumn(model: model)),
          );
        },
        viewModelBuilder: () => TaskModel());
  }
}
