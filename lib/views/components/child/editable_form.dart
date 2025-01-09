import 'package:go_do/models/Task.dart';
import 'package:go_do/views/pages/tasks.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_do/views/starters/navigation.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/view_models/task_model.dart';
import 'package:go_do/views/components/child/form_button.dart';
import 'package:go_do/views/components/child/task_check_box.dart';

class EditableForm extends StatelessWidget {
  final bool isHomeReturn;
  final Task task;
  const EditableForm(
      {super.key, required this.task, required this.isHomeReturn});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskModel>.reactive(
        builder: (context, model, child) {
          Widget _targetWidget = isHomeReturn
              ? const Navigation()
              : TasksPage(
                  taskCategory: model.categoryBox.getAt(task.categoryKey)!.name,
                );
          final double width = MediaQuery.of(context).size.width * .4;
          return Form(
            key: model.formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Column(
                children: [
                  Row(
                    children: [
                      TaskCheckBox(task: task),
                      const SizedBox(width: 10),
                      Text('Accomplish task')
                    ],
                  ),
                  const SizedBox(height: 15),
                  model.buildTextFormField(
                      controller: model.nameController,
                      validator: model.validateInputLength,
                      hintText: task.name,
                      labelText: 'Name'),
                  const SizedBox(height: 30),
                  model.buildDropdownFormField(
                    items: model.categoryNames,
                    hintText:
                    model.categoryBox.getAt(task.categoryKey)!.name,
                    labelText: 'Category',
                    onChanged: (newValue) {
                      model.getCategoryKey(newValue);
                    },
                  ),
                  const SizedBox(height: 30),
                  model.buildTextFormField(
                      controller: model.dateController,
                      validator: model.validateEmptyField,
                      hintText: DateFormat('dd MMMM, y')
                          .format(DateTime.parse(task.tacklingDate)),
                      labelText: 'Tackling date',
                      onTap: () => _showDatePicker(context, model)),
                  const SizedBox(height: 30),
                  model.buildTextFormField(
                      controller: model.startTimeController,
                      validator: model.validateEmptyField,
                      hintText: task.startTime,
                      labelText: 'Start time',
                      onTap: () => _showTimePicker(context, model,
                          timeStatus: 'start')),
                  const SizedBox(height: 30),
                  model.buildTextFormField(
                      controller: model.endTimeController,
                      validator: model.validateEmptyField,
                      hintText: task.endTime,
                      labelText: 'End time',
                      onTap: () => _showTimePicker(context, model)),
                  const SizedBox(height: 30),
                  model.buildDropdownFormField(
                    items: model.priorityItems,
                    hintText: task.priority,
                    labelText: 'Priority',
                    onChanged: (newValue) {
                      model.setSelectedPriority(newValue);
                    },
                  ),
                  const SizedBox(height: 20),
                  const Row(),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FormButton(
                          onPressed: () {
                            model.updateTask(task);
                          },
                          backgroundColor: Colors.green,
                          text: 'Save',
                          icon: Icons.save,
                          width: width),
                      FormButton(
                          onPressed: () {
                            model.deleteTask(task.key);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => _targetWidget));
                          },
                          backgroundColor: Colors.red,
                          text: 'Remove',
                          icon: Icons.delete,
                          width: width)
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => TaskModel());
  }
}

void _showDatePicker(BuildContext context, TaskModel model) {
  showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030))
      .then((value) => model.updateDate(value));
}

void _showTimePicker(BuildContext context, TaskModel model,
    {String? timeStatus}) async {
  TimeOfDay? newTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  model.updateTime(newTime, timeStatus);
}
