import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:go_do/models/Category.dart';
import 'package:go_do/themes/theme_assets.dart';
import 'package:go_do/view_models/category_model.dart';
import 'package:go_do/views/components/child/task_status_container.dart';

class CategoryGestureDetectorColumn extends StatelessWidget {
  final CategoryModel model;
  final Category category;
  const CategoryGestureDetectorColumn({super.key, required this.category, required this.model});

  @override
  Widget build(BuildContext context) {
    final totalTasks = model.getTotalCategoryTasks(category.name);
    final accomplishedTasks =
    model.getTotalCategoryTasksAccomplished(category.name);
    final totalCategoryTasksLeft =
    model.getTotalCategoryTasksLeft(category.name);
    final isEmpty = totalTasks == 0 || accomplishedTasks == 0;
    final double accomplishedPercent =
    isEmpty ? 0 : model.getAccomplishedCategoryPercent(category.name);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircularPercentIndicator(
              radius: 25,
              animation: true,
              animationDuration: 1000,
              lineWidth: 5,
              percent: accomplishedPercent,
              backgroundColor: AppColors.lightGray,
              progressColor: Color(category.categoryColor),
              center: Text(
                isEmpty
                    ? "0%"
                    : "${(accomplishedPercent * 100).toInt()}%",
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(category.categoryColor),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              category.name,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '$totalTasks ${totalTasks < 2 ? 'task' : 'tasks'}',
              style: const TextStyle(
                color: Colors.black26,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TaskStatusContainer(
                category: category,
                isComplete: true,
                NumberOfTasks: accomplishedTasks),
            TaskStatusContainer(
                category: category,
                isComplete: false,
                NumberOfTasks: totalCategoryTasksLeft)
          ],
        ),
      ],
    );
  }
}
