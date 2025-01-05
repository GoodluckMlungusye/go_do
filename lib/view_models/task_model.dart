import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:hive/hive.dart';
import 'package:go_do/models/Task.dart';
import 'package:go_do/models/Category.dart';

class TaskModel extends BaseViewModel {
  late final Box<Task> taskBox;
  late final Box<Category> categoryBox;
  late final int _selectedCategory;
  final double _leftPadding = 13;
  final List<String> _priorityItems = ['High', 'Medium', 'Low'];

  List<String> getCategoryNames(List<Category> categories) {
    return categories.map((category) => category.name).toList();
  }

  final _formKey = GlobalKey<FormState>();

  DateTime _dateTime = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  void getCategoryKey(String newValue) {
    final matchingKey = categoryBox.keys.firstWhere(
      (key) => categoryBox.get(key)?.name == newValue,
      orElse: () => null,
    );

    if (matchingKey != null) {
      _selectedCategory = matchingKey;
      notifyListeners();
    } else {
      debugPrint('Category "$newValue" not found.');
    }
  }
}
