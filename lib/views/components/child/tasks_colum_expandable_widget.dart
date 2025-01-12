import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/task_model.dart';
import 'package:go_do/views/pages/my_task.dart';
import 'package:go_do/models/Task.dart';

class TasksColumnExpandableWidget extends StatelessWidget {
  const TasksColumnExpandableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskModel>.reactive(
      builder: (context, model, child) {
        return Expanded(
          child: model.filteredTaskList.isEmpty
              ? const Center(child: Text("No tasks found"))
              : ListView.builder(
            itemCount: model.filteredTaskList.length,
            itemBuilder: (BuildContext context, index) {
              final task = model.filteredTaskList[index];
              return Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 8),
                child: SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => MyTaskPage(
                                      task: task, isHomeReturn: false)));
                        },
                        title: _buildListTileTitle(model, task),
                        leading: model.getPriorityIcon(task.priority),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      viewModelBuilder: () => TaskModel(),
    );
  }
}

Widget _buildListTileTitle(TaskModel model, Task task) {
  TextDecoration textDecoration =
      task.isFinished ? TextDecoration.lineThrough : TextDecoration.none;
  String timeText = "${task.startTime} - ${task.endTime}";
  FontWeight fontWeight = task.isFinished ? FontWeight.normal : FontWeight.bold;
  return Column(
    children: [
      Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              task.name,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: fontWeight,
                  decoration: textDecoration,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          model.getDurationWidget(task.tacklingDate),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            timeText,
            style: TextStyle(fontSize: 11, decoration: textDecoration),
          ),
        ],
      )
    ],
  );
}
