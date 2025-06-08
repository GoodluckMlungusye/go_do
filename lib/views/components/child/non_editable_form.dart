import 'package:go_do/models/Task.dart';
import 'package:go_do/views/pages/tasks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_do/views/starters/main_layout.dart';
import 'package:go_do/view_models/task_model.dart';
import 'package:go_do/views/components/child/form_button.dart';
import 'package:go_do/views/components/child/task_check_box.dart';

class NonEditableForm extends StatelessWidget {
  final TaskModel model;
  final bool isHomeReturn;
  final Task task;
  const NonEditableForm(
      {super.key,
      required this.task,
      required this.isHomeReturn,
      required this.model});

  @override
  Widget build(BuildContext context) {
    Widget _targetWidget = isHomeReturn
        ? const MainLayout()
        : TasksPage(
            taskCategory: model.categoryBox.getAt(task.categoryKey)!.name,
          );
    final double width = MediaQuery.of(context).size.width * .9;
    return Form(
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
        child: Column(
          children: [
            const Row(),
            const SizedBox(height: 15),
            _buildPadding(model, 'Task Name', task.name),
            const SizedBox(height: 30),
            _buildPadding(model, 'Category',
                model.categoryBox.getAt(task.categoryKey)!.name),
            const SizedBox(height: 30),
            _buildPadding(
                model,
                'Tackling date',
                DateFormat('dd MMMM, y')
                    .format(DateTime.parse(task.tacklingDate))),
            const SizedBox(height: 30),
            _buildPadding(model, 'Start time', task.startTime),
            const SizedBox(height: 30),
            _buildPadding(model, 'End time', task.endTime),
            const SizedBox(height: 30),
            _buildPadding(model, 'Priority', task.priority),
            const SizedBox(height: 20),
            Row(
              children: [
                TaskCheckBox(task: task),
                const SizedBox(width: 2),
                Text('Re-schedule task'),
              ],
            ),
            const SizedBox(height: 25),
            FormButton(
                onPressed: () {
                  model.deleteTask(task.key);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => _targetWidget));
                },
                backgroundColor: Colors.red,
                text: 'Remove',
                icon: Icons.delete,
                width: width),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

Widget _buildPadding(TaskModel model, String label, String text) {
  return Padding(
    padding: EdgeInsets.only(left: model.leftPadding),
    child: Row(children: [
      Text('${label}: ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(width: 10),
      Text(text, style: const TextStyle(fontSize: 15))
    ]),
  );
}
