import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/views/components/child/progress_viewer.dart';
import 'package:go_do/models/Task.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:go_do/utils/toast_messages/success_toast_message.dart';
import 'package:go_do/view_models/home_model.dart';
import 'package:go_do/views/pages/my_task.dart';

class HomeExpandableWidget extends StatelessWidget {
  const HomeExpandableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeModel>.reactive(
        builder: (context, model, child) => Expanded(
              child: ValueListenableBuilder(
                  valueListenable: model.taskBox.listenable(),
                  builder: (context, box, child) {
                    return ListView.builder(
                        itemCount: model.taskBox.length,
                        itemBuilder: (BuildContext context, index) {
                          final task = model.taskBox.getAt(index) as Task;
                          if (!model.isToday(task.tacklingDate)) {
                            return Container();
                          }
                          return _taskCard(context, model, task, index);
                        });
                  }),
            ),
        viewModelBuilder: () => HomeModel());
  }
}

Widget _taskCard(BuildContext context, HomeModel model, Task task, int index) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
    child: SizedBox(
      height: 80,
      width: double.infinity,
      child: Card(
        elevation: 4,
        child: ListTile(
          onTap: () => {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    MyTaskPage(task: task, isHomeReturn: true)))
          },
          title: _buildTaskTitle(model, task),
          subtitle: _buildTaskSubtitle(task),
          leading: _buildCheckbox(context, model, task, index),
          trailing: _buildTrailingIcon(context, model, task),
        ),
      ),
    ),
  );
}

Widget _buildTaskTitle(HomeModel model, Task task) {
  return Row(
    children: [
      Flexible(
        child: Text(
          task.name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: task.isFinished ? FontWeight.normal : FontWeight.bold,
            decoration: task.isFinished
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      const SizedBox(width: 20),
      model.getPriorityIcon(task.priority),
    ],
  );
}

Widget _buildTaskSubtitle(Task task) {
  return Text(
    "${task.startTime} - ${task.endTime}",
    style: TextStyle(
      fontSize: 12,
      decoration:
          task.isFinished ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

Widget _buildCheckbox(
  BuildContext context,
  HomeModel model,
  Task task,
  int index,
) {
  return Checkbox(
    activeColor: AppColors.primaryColorLight,
    side: const BorderSide(color: AppColors.primaryColorLight),
    value: task.isFinished,
    onChanged: (newBool) {
      model.handleCheckBoxChange(newBool, task, index);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ProgressViewer(),
        ),
      );
    },
  );
}

Widget _buildTrailingIcon(BuildContext context, HomeModel model, Task task) {
  if (task.isFinished) {
    return IconButton(
      onPressed: () {
        model.deleteTask(task.key);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProgressViewer(),
          ),
        );
      },
      icon: const Icon(Icons.delete, color: Colors.red),
    );
  } else {
    return const Icon(Icons.arrow_forward_ios_rounded);
  }
}

