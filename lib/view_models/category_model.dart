import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/models/Category.dart';
import 'package:go_do/models/Task.dart';

class CategoryModel extends BaseViewModel {
  CategoryModel() {
    taskBox = Hive.box<Task>('task');
    categoryBox = Hive.box<Category>('category');
  }

  late final Box<Task> taskBox;
  late final Box<Category> categoryBox;

  /// Returns the total number of tasks
  int getTotalTasks() => taskBox.length;

  /// Returns the total number of tasks that are accomplished
  int getTotalTasksAccomplished() {
    return taskBox.values.where((task) => task.isFinished).length;
  }

  /// Returns the percentage of tasks accomplished
  double getAccomplishedPercent() {
    final totalTasks = getTotalTasks();
    return totalTasks > 0 ? getTotalTasksAccomplished() / totalTasks : 0.0;
  }

  /// Returns the total number of tasks for a given category
  int getTotalCategoryTasks(String categoryName) {
    return taskBox.values
        .where(
            (task) => categoryBox.getAt(task.categoryKey)?.name == categoryName)
        .length;
  }

  /// Returns the total number of tasks accomplished for a given category
  int getTotalCategoryTasksAccomplished(String categoryName) {
    return taskBox.values
        .where((task) =>
            categoryBox.getAt(task.categoryKey)?.name == categoryName &&
            task.isFinished)
        .length;
  }

  /// Returns the percentage of accomplished tasks for a given category
  double getAccomplishedCategoryPercent(String categoryName) {
    final totalCategoryTasks = getTotalCategoryTasks(categoryName);
    return totalCategoryTasks > 0
        ? getTotalCategoryTasksAccomplished(categoryName) / totalCategoryTasks
        : 0.0;
  }

  /// Returns the total number of tasks left for a given category
  int getTotalCategoryTasksLeft(String categoryName) {
    return getTotalCategoryTasks(categoryName) -
        getTotalCategoryTasksAccomplished(categoryName);
  }

  /// Generates a completion message based on the number of completed tasks
  String getCompletionMessage(int accomplishedTasks, int totalTasks) {
    return accomplishedTasks < 2
        ? "$accomplishedTasks out of $totalTasks is completed"
        : "$accomplishedTasks out of $totalTasks are completed";
  }

  /// Generates a motivational message based on the accomplished percent
  String getMotivationalMessage(double accomplishedPercent) {
    return accomplishedPercent < 0.5
        ? "Finish more tasks, reach your plans!"
        : "Hello, You are almost there!";
  }
}
