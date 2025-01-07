import 'package:flutter/material.dart';
import 'package:go_do/services/task_service.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/models/Task.dart';
import 'package:go_do/services/service_injector/dependency_container.dart';

class HomeModel extends BaseViewModel {
  HomeModel() {
    taskBox = Hive.box<Task>('task');
    refreshTodayTasks();
  }

  final _taskService = locator.get<TaskService>();
  late final Box<Task> taskBox;
  List<Task> _completedTodayTasks = [];
  List<Task> _todayTasks = [];

  List<Task> get completedTodayTasks => _completedTodayTasks;
  List<Task> get todayTasks => _todayTasks;

  void refreshTodayTasks() {
    _todayTasks = _getTodayTasks();
    _completedTodayTasks =
        _todayTasks.where((task) => task.isFinished).toList();
    notifyListeners();
  }

  int getTotalTasksToday() => _todayTasks.length;

  int getTotalTasksAccomplishedToday() => _completedTodayTasks.length;

  double getPercentAccomplishedToday() {
    final totalTasks = getTotalTasksToday();
    return totalTasks > 0 ? getTotalTasksAccomplishedToday() / totalTasks : 0.0;
  }

  bool isToday(String date) {
    final taskDate = DateTime.parse(date);
    final today = DateTime.now();
    return taskDate.year == today.year &&
        taskDate.month == today.month &&
        taskDate.day == today.day;
  }

  List<Task> _getTodayTasks() {
    return taskBox.values
        .where((task) => isToday(task.tacklingDate))
        .toList();
  }

  Widget getPriorityIcon(String priority) {
    return _taskService.getPriorityIcon(priority);
  }

  Future<void> deleteTask(int taskKey) async {
    await taskBox.delete(taskKey);
    refreshTodayTasks();
  }

  void handleCheckBoxChange(bool? value, Task task, int index) {
    if (value == null) return;
    final updatedTask = task.copyWith(isFinished: value);
    taskBox.putAt(index, updatedTask);
    refreshTodayTasks();
  }
}
