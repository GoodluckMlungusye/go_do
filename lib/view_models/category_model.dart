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

  String getCompletionMessage(int accomplishedTasks, int totalTasks) {
    return accomplishedTasks < 2
        ? "$accomplishedTasks out of $totalTasks is completed"
        : "$accomplishedTasks out of $totalTasks are completed";
  }

  String getMotivationalMessage(double accomplishedPercent) {
    return accomplishedPercent < 0.5
        ? "Finish more tasks, reach your plans!"
        : "Hello, You are almost there!";
  }
}
