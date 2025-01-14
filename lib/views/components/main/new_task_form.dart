import 'package:flutter/material.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:intl/intl.dart';
import 'package:go_do/view_models/task_model.dart';
import 'package:go_do/views/pages/new_category.dart';

class NewTaskForm extends StatelessWidget {
  final TaskModel model;
  const NewTaskForm({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    String hintDate = DateFormat('dd MMMM, y').format(model.dateTime);
    return Form(
      key: model.formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
        child: Column(
          children: [
            model.buildTextFormField(
                controller: model.nameController,
                validator: model.validateInputLength,
                hintText: '',
                labelText: 'Task Name'),
            const SizedBox(height: 30),
            model.categoryNames.isNotEmpty
                ? model.buildDropdownFormField(
                    items: model.categoryNames,
                    hintText: '',
                    labelText: 'Category',
                    onChanged: (newValue) {
                      model.getCategoryKey(newValue);
                    },
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const NewCategoryPage()));
                    },
                    child: model.buildDropdownFormField(
                      items: model.categoryNames,
                      hintText: '',
                      labelText: 'Category',
                      onChanged: (newValue) {},
                    ),
                  ),
            const SizedBox(height: 30),
            model.buildTextFormField(
                controller: model.dateController,
                validator: model.validateEmptyField,
                hintText: hintDate,
                suffixIcon:
                    const Icon(Icons.calendar_month, color: Colors.black26),
                onTap: () => _showDatePicker(context, model),
                labelText: 'Tackling date'),
            const SizedBox(height: 30),
            model.buildTextFormField(
                controller: model.startTimeController,
                validator: model.validateEmptyField,
                hintText: hintDate,
                onTap: () =>
                    _showTimePicker(context, model, timeStatus: 'start'),
                labelText: 'Start time'),
            const SizedBox(height: 30),
            model.buildTextFormField(
                controller: model.endTimeController,
                validator: model.validateEmptyField,
                hintText: hintDate,
                onTap: () => _showTimePicker(context, model),
                labelText: 'End time'),
            const SizedBox(height: 30),
            model.buildDropdownFormField(
              items: model.priorityItems,
              hintText: '',
              labelText: 'Priority',
              onChanged: (newValue) {
                model.setSelectedPriority(newValue);
              },
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () {
                    model.addTask();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  child: const Text("Create",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white))),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
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
