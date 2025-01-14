import 'package:go_do/models/Task.dart';
import 'package:flutter/material.dart';
import 'package:go_do/view_models/task_model.dart';
import 'package:go_do/views/components/child/editable_form.dart';
import 'package:go_do/views/components/child/non_editable_form.dart';

class TaskForm extends StatelessWidget {
  final TaskModel model;
  final bool isHomeReturn;
  final Task task;
  const TaskForm({super.key, required this.task, required this.isHomeReturn, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        task.isFinished
            ? NonEditableForm(model: model, task: task, isHomeReturn: isHomeReturn)
            : EditableForm(model: model, task: task, isHomeReturn: isHomeReturn)
      ],
    );
  }
}

