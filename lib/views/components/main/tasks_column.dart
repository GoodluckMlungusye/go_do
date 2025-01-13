import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/task_model.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:go_do/views/components/child/tasks_colum_expandable_widget.dart';

class TasksColumn extends StatelessWidget {
  final String taskCategory;
  const TasksColumn({super.key, required this.taskCategory});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskModel>.reactive(
        onViewModelReady: (model) => model.initialize(taskCategory),
        builder: (context, model, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 12, right: 12, bottom: 10),
                child: TextField(
                  onChanged: model.filterTasks,
                  decoration: InputDecoration(
                      focusColor: AppColors.primaryColor,
                      hintText: 'search task',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.black38,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.primaryColor))),
                ),
              ),
              const SizedBox(height: 20),
              TasksColumnExpandableWidget(model: model)
            ],
          );
        },
        viewModelBuilder: () => TaskModel());
  }
}
