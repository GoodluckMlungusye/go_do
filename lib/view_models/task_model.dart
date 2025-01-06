import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:hive/hive.dart';
import 'package:go_do/models/Task.dart';
import 'package:go_do/models/Category.dart';

class TaskModel extends BaseViewModel {

  late final Box<Task> taskBox;
  late final Box<Category> categoryBox;
  late final int _selectedCategory;
  late final String _selectedPriority;
  final double _leftPadding = 13;
  final List<String> _priorityItems = ['High', 'Medium', 'Low'];


  List<String> getCategoryNames(List<Category> categories) {
    return categories.map((category) => category.name).toList();
  }

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

  final _formKey = GlobalKey<FormState>();

  DateTime _dateTime = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  void updateDate(DateTime value) {
    _dateTime = value;
    _dateController.text = DateFormat('dd MMMM, y').format(_dateTime);
    notifyListeners();
  }

  void updateTime(TimeOfDay? newTime, String? timeStatus) {
    if (newTime != null) {
      if (timeStatus == 'start') {
        _startTime = newTime;
        _startTimeController.text = _formatTime(newTime);
      } else {
        _endTime = newTime;
        _endTimeController.text = _formatTime(newTime);
      }
      notifyListeners();
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour < 10 ? '0${time.hour}' : '${time.hour}';
    final minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
    return '$hour:$minute hrs';
  }


  // void _showTimePicker({String? timeStatus}) async {
  //   TimeOfDay initialTime = timeStatus == 'start' ? _startTime : _endTime;
  //   TimeOfDay? newTime = await showTimePicker(
  //     context: context,
  //     initialTime: initialTime,
  //   );
  //   model.updateTime(newTime,timeStatus);
  // }
}
