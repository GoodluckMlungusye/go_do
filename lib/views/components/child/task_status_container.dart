import 'package:flutter/material.dart';
import 'package:go_do/models/Category.dart';

class TaskStatusContainer extends StatelessWidget {
  final Category category;
  final bool isComplete;
  final int NumberOfTasks;
  const TaskStatusContainer(
      {super.key,
      required this.category,
      required this.isComplete,
      required this.NumberOfTasks});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient:
          LinearGradient(begin: Alignment.bottomRight, colors: [
            Color(category.categoryColor).withOpacity(.16),
            Color(category.categoryColor).withOpacity(.16),
          ])),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: Text(
            '$NumberOfTasks ${isComplete ? 'completed' : 'left'}',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: isComplete
                  ? Color(category.categoryColor)
                  : Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
