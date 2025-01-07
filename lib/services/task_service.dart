import 'package:flutter/material.dart';

class TaskService{

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

}