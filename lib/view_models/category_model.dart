import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/models/Category.dart';
import 'package:go_do/models/Task.dart';
import 'package:go_do/services/service_injector/dependency_container.dart';
import 'package:go_do/services/task_service.dart';
import 'package:go_do/themes/theme_assets.dart';

class CategoryModel extends BaseViewModel {
  CategoryModel() {
    taskBox = Hive.box<Task>('task');
    categoryBox = Hive.box<Category>('category');
  }

  final _taskService = locator.get<TaskService>();
  late final Box<Task> taskBox;
  late final Box<Category> categoryBox;
  Color categoryColor = Colors.deepPurple;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;

  int getTotalTasks() => taskBox.length;

  int getTotalTasksAccomplished() {
    return taskBox.values.where((task) => task.isFinished).length;
  }

  double getAccomplishedPercent() {
    final totalTasks = getTotalTasks();
    return totalTasks > 0 ? getTotalTasksAccomplished() / totalTasks : 0.0;
  }

  int getTotalCategoryTasks(String categoryName) {
    return taskBox.values
        .where(
            (task) => categoryBox.getAt(task.categoryKey)?.name == categoryName)
        .length;
  }

  int getTotalCategoryTasksAccomplished(String categoryName) {
    return taskBox.values
        .where((task) =>
            categoryBox.getAt(task.categoryKey)?.name == categoryName &&
            task.isFinished)
        .length;
  }

  double getAccomplishedCategoryPercent(String categoryName) {
    final totalCategoryTasks = getTotalCategoryTasks(categoryName);
    return totalCategoryTasks > 0
        ? getTotalCategoryTasksAccomplished(categoryName) / totalCategoryTasks
        : 0.0;
  }

  int getTotalCategoryTasksLeft(String categoryName) {
    return getTotalCategoryTasks(categoryName) -
        getTotalCategoryTasksAccomplished(categoryName);
  }

  // String getCompletionMessage(int accomplishedTasks, int totalTasks) {
  //   return accomplishedTasks < 2
  //       ? "$accomplishedTasks out of $totalTasks is completed"
  //       : "$accomplishedTasks out of $totalTasks are completed";
  // }

  String getCompletionMessage(int accomplishedTasks, int totalTasks) {
    if (accomplishedTasks == 0) {
      return "No tasks accomplished";
    }
    return accomplishedTasks < 2
        ? "$accomplishedTasks out of $totalTasks is completed"
        : "$accomplishedTasks out of $totalTasks are completed";
  }

  String getMotivationalMessage(double accomplishedPercent) {
    return accomplishedPercent < 0.5
        ? "Finish more tasks, reach your plans!"
        : "Hello, You are almost there!";
  }

  void addCategory() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final newCategory = Category(
        name: nameController.text.trim(),
        categoryColor: categoryColor.value,
      );
      categoryBox.add(newCategory);
      _resetForm();
      notifyListeners();
      _showToast('Category added successfully', Colors.green);
    }
  }

  void _resetForm() {
    nameController.clear();
    categoryColor = AppColors.primaryColor;
  }

  Widget buildColorPicker() => ColorPicker(
      pickerColor: categoryColor,
      enableAlpha: false,
      onColorChanged: (color) => _changeColor(color));

  String? validateInputLength(String? input) {
    return _taskService.validateInputLength(input);
  }

  void _changeColor(Color color) {
    categoryColor = color;
    notifyListeners();
  }

  void _showToast(String message, Color backgroundColor) {
    _taskService.showToast(message, backgroundColor);
  }
}
