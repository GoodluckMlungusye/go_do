import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';
import 'package:go_do/models/Category.dart';
import 'package:go_do/models/Task.dart';

class CategoryModel extends BaseViewModel {
  CategoryModel() {
    taskBox = Hive.box('task');
    categoryBox = Hive.box('category');
  }

  late Box<Task> taskBox;
  late Box<Category> categoryBox;

  List<Task> totalTasksAccomplished = [];

  List<Task> totalCategoryTasks = [];

  List<Task> totalCategoryTasksAccomplished = [];

  int getTotalTasks() {
    return taskBox.length;
  }

  // int getTotalTasksAccomplished() {
  //   totalTasksAccomplished.clear();
  //   for (Task task in taskBox.values.toList()) {
  //     if (task.isFinished) {
  //       totalTasksAccomplished.add(task);
  //     }
  //   }
  //   return totalTasksAccomplished.length;
  // }

  int getTotalTasksAccomplished() {
    return taskBox.values.where((task) => task.isFinished).length;
  }

  double getAccomplishedPercent() {
    return getTotalTasksAccomplished() / getTotalTasks();
  }

  // int getTotalCategoryTasks(String categoryName) {
  //   totalCategoryTasks.clear();
  //   for (Task task in taskBox.values.toList()) {
  //     if (categoryBox.getAt(task.categoryKey)!.name == categoryName) {
  //       totalCategoryTasks.add(task);
  //     }
  //   }
  //   return totalCategoryTasks.length;
  // }

  int getTotalCategoryTasks(String categoryName) {
    return taskBox.values
        .where(
            (task) => categoryBox.getAt(task.categoryKey)?.name == categoryName)
        .length;
  }

  // int getTotalCategoryTasksAccomplished(String categoryName) {
  //   totalCategoryTasksAccomplished.clear();
  //   for (Task task in taskBox.values.toList()) {
  //     if (categoryBox.getAt(task.categoryKey)!.name == categoryName &&
  //         task.isFinished) {
  //       totalCategoryTasksAccomplished.add(task);
  //     }
  //   }
  //   return totalCategoryTasksAccomplished.length;
  // }

  int getTotalCategoryTasksAccomplished(String categoryName) {
    return taskBox.values
        .where((task) =>
            categoryBox.getAt(task.categoryKey)?.name == categoryName &&
            task.isFinished)
        .length;
  }

  // double getAccomplishedCategoryPercent(String categoryName) {
  //   return getTotalCategoryTasksAccomplished(categoryName) /
  //       getTotalCategoryTasks(categoryName);
  // }

  double getAccomplishedCategoryPercent(String categoryName) {
    int totalTasks = getTotalCategoryTasks(categoryName);
    if (totalTasks == 0) {
      return 0.0;
    }
    return getTotalCategoryTasksAccomplished(categoryName) / totalTasks;
  }

  // int getTotalCategoryTasksLeft(String categoryName) {
  //   return (getTotalCategoryTasks(categoryName) -
  //       getTotalCategoryTasksAccomplished(categoryName));
  // }

  int getTotalCategoryTasksLeft(String categoryName) {
    int totalTasks = getTotalCategoryTasks(categoryName);
    int accomplishedTasks = getTotalCategoryTasksAccomplished(categoryName);

    return (totalTasks - accomplishedTasks).clamp(0, totalTasks);
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
