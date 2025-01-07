import 'package:go_do/models/Task.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/task_model.dart';
import 'package:go_do/views/components/child/editable_form.dart';
import 'package:go_do/views/components/child/non_editable_form.dart';

class TaskForm extends StatelessWidget {
  final bool isHomeReturn;
  final Task task;
  const TaskForm({super.key, required this.task, required this.isHomeReturn});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskModel>.reactive(
        builder: (context, model, child) {
          return Column(
            children: [
              task.isFinished
                  ? NonEditableForm(task: task, isHomeReturn: isHomeReturn)
                  : EditableForm(task: task, isHomeReturn: isHomeReturn)
            ],
          );
        },
        viewModelBuilder: () => TaskModel());
  }
}

