import 'package:go_do/models/Task.dart';
import 'package:go_do/views/pages/my_tasks.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:go_do/models/Category.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:intl/intl.dart';
import 'package:go_do/views/starters/navigation.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/task_model.dart';


class MyTaskPage extends StatelessWidget {
  final bool isHomeReturn;
  final Task task;
  const MyTaskPage({super.key, required this.task, required this.isHomeReturn});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskModel>.reactive(
        builder: (context, model, child) => Expanded(
          child: Text('')
        ),
        viewModelBuilder: () => TaskModel());
  }
}
