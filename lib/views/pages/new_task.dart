import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/task_model.dart';
import 'package:go_do/views/starters/main_layout.dart';
import 'package:go_do/views/components/main/new_task_form.dart';

class NewTaskPage extends StatelessWidget {
  const NewTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskModel>.reactive(
        builder: (context, model, child) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const MainLayout()));
                    },
                    icon: const Icon(Icons.arrow_back_ios,
                        color: Colors.black26)),
                title: const Text(
                  'Create Task',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    NewTaskForm(model: model)
                  ],
                ),
              ),
            ),
          );
        },
        viewModelBuilder: () => TaskModel());
  }
}

