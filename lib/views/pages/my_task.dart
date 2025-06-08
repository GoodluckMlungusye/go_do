import 'package:go_do/models/Task.dart';
import 'package:go_do/views/pages/tasks.dart';
import 'package:flutter/material.dart';
import 'package:go_do/views/starters/main_layout.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/task_model.dart';
import 'package:go_do/views/components/main/task_form.dart';

class MyTaskPage extends StatelessWidget {
  final bool isHomeReturn;
  final Task task;
  const MyTaskPage({super.key, required this.task, required this.isHomeReturn});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskModel>.reactive(
        builder: (context, model, child) {
          Widget _targetWidget = isHomeReturn
              ? const MainLayout()
              : TasksPage(
                  taskCategory: model.categoryBox.getAt(task.categoryKey)!.name,
                );
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => _targetWidget));
                    },
                    icon: const Icon(Icons.arrow_back_ios,
                        color: Colors.black26)),
                title: const Text(
                  'Manage Task',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                  child: TaskForm(model: model, task: task, isHomeReturn: isHomeReturn)),
            ),
          );
        },
        viewModelBuilder: () => TaskModel());
  }
}
