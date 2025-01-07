import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:hive/hive.dart';
import 'package:go_do/models/Task.dart';
import 'package:go_do/models/Category.dart';
import 'package:go_do/services/service_injector/dependency_container.dart';
import 'package:go_do/services/task_service.dart';

class TaskModel extends BaseViewModel {
  TaskModel() {
    taskBox = Hive.box<Task>('task');
    categoryBox = Hive.box<Category>('category');
    _categoryList = categoryBox.values.toList();
    _categoryNames = _getCategoryNames(_categoryList);
  }

  final _taskService = locator.get<TaskService>();
  final double _leftPadding = 13;
  late final Box<Task> taskBox;
  late final Box<Category> categoryBox;
  late final int _selectedCategory;
  late final String _selectedPriority;
  late final List<Category> _categoryList;
  late final List<String> _categoryNames;
  final List<String> _priorityItems = ['High', 'Medium', 'Low'];
  DateTime _dateTime = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  double get leftPadding => _leftPadding;
  List<String> get categoryNames => _categoryNames;
  List<String> get priorityItems => _priorityItems;
  GlobalKey<FormState> get formKey => _formKey;

  List<String> _getCategoryNames(List<Category> categories) {
    return categories.map((category) => category.name).toList();
  }

  void getCategoryKey(String? newValue) {
    final matchingKey = categoryBox.keys.firstWhere(
      (key) => categoryBox.get(key)?.name == newValue,
      orElse: () => null,
    );
    if (matchingKey != null) {
      _selectedCategory = matchingKey;
      notifyListeners();
    } else {
      _showToast('Category "$newValue" not found.', Colors.red);
    }
  }

  void setSelectedPriority(String? newValue) {
    _selectedPriority = newValue!;
    notifyListeners();
  }

  String? validateEmptyField(String? input) {
    if (input == null || input.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  String? validateInputLength(String? input) {
    final emptyValidation = validateEmptyField(input);
    if (emptyValidation != null) {
      return emptyValidation;
    } else if (input!.length < 4) {
      return 'At least 4 characters are required!';
    }
    return null;
  }

  void updateDate(DateTime? value) {
    _dateTime = value!;
    dateController.text = DateFormat('dd MMMM, y').format(_dateTime);
    notifyListeners();
  }

  void updateTime(TimeOfDay? newTime, String? timeStatus) {
    if (newTime != null) {
      if (timeStatus == 'start') {
        startTimeController.text = _formatTime(newTime);
      } else {
        endTimeController.text = _formatTime(newTime);
      }
      notifyListeners();
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour < 10 ? '0${time.hour}' : '${time.hour}';
    final minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
    return '$hour:$minute hrs';
  }

  void updateTask(Task task) {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      _formKey.currentState?.save();
      final _updatedTask = task.copyWith(
          name: nameController.text,
          categoryKey: _selectedCategory,
          tacklingDate: _dateTime.toString(),
          startTime: startTimeController.text,
          endTime: endTimeController.text,
          priority: _selectedPriority);
      taskBox.put(task.key, _updatedTask);
      notifyListeners();
      _showToast('task updated successfully', Colors.green);
    }
  }

  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> deleteTask(int taskKey) async {
    await taskBox.delete(taskKey);
    notifyListeners();
  }

  void handleCheckBoxChange(bool? value, Task task) {
    if (value == null) return;
    final updatedTask = task.copyWith(isFinished: value);
    taskBox.putAt(task.key, updatedTask);
    notifyListeners();
  }

  Widget getPriorityIcon(String priority) {
    return _taskService.getPriorityIcon(priority);
  }

  List<Task> getCategoryTasks(String taskCategory) {
    return taskBox.values
        .where(
            (task) => categoryBox.getAt(task.categoryKey)!.name == taskCategory)
        .toList();
  }
}
