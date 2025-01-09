import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TaskService{

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

  void showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

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