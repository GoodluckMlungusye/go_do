import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/models/Task.dart';

class HomeModel extends BaseViewModel {
  HomeModel() {
    taskBox = Hive.box<Task>('task');
    refreshTodayTasks();
  }

  late final Box<Task> taskBox;

  List<Task> _completedTodayTasks = [];
  List<Task> _todayTasks = [];

  /// Getters for public access
  List<Task> get completedTodayTasks => _completedTodayTasks;
  List<Task> get todayTasks => _todayTasks;

  /// Refresh today's tasks and notify listeners
  void refreshTodayTasks() {
    _todayTasks = _getTodayTasks();
    _completedTodayTasks =
        _todayTasks.where((task) => task.isFinished).toList();
    notifyListeners();
  }

  /// Returns the total number of tasks for today
  int getTotalTasksToday() => _todayTasks.length;

  /// Returns the number of tasks accomplished today
  int getTotalTasksAccomplishedToday() => _completedTodayTasks.length;

  /// Calculates the percentage of accomplished tasks today
  double getPercentAccomplishedToday() {
    final totalTasks = getTotalTasksToday();
    return totalTasks > 0 ? getTotalTasksAccomplishedToday() / totalTasks : 0.0;
  }

  /// Determines if the given date is today
  bool isToday(String date) {
    final taskDate = DateTime.parse(date);
    final today = DateTime.now();
    return taskDate.year == today.year &&
        taskDate.month == today.month &&
        taskDate.day == today.day;
  }

  /// Returns the tasks for today
  List<Task> _getTodayTasks() {
    return taskBox.values
        .where((task) => isToday(task.tacklingDate))
        .toList();
  }

  /// Returns the priority icon based on the priority level
  Widget getPriorityIcon(String priority) {
    switch (priority) {
      case 'High':
        return const Icon(Icons.keyboard_double_arrow_up, color: Colors.red);
      case 'Medium':
        return const Icon(Icons.dehaze, color: Colors.green);
      case 'Low':
        return const Icon(Icons.keyboard_double_arrow_down,
            color: Colors.yellow);
      default:
        return const Icon(Icons.error, color: Colors.grey);
    }
  }

  /// Deletes a task by its key
  Future<void> deleteTask(int taskKey) async {
    await taskBox.delete(taskKey);
    refreshTodayTasks();
  }

  /// Handles checkbox state change for a task
  void handleCheckBoxChange(bool? value, Task task, int index) {
    if (value == null) return;

    final updatedTask = task.copyWith(isFinished: value);
    taskBox.putAt(index, updatedTask);
    refreshTodayTasks();
  }
}
