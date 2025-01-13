import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:hive/hive.dart';
import 'package:go_do/models/Task.dart';
import 'package:go_do/models/Category.dart';
import 'package:go_do/services/service_injector/dependency_container.dart';
import 'package:go_do/services/task_service.dart';
import 'package:go_do/themes/theme_assets.dart';

class TaskModel extends BaseViewModel {
  TaskModel() {
    taskBox = Hive.box<Task>('task');
    categoryBox = Hive.box<Category>('category');
    _categoryList = categoryBox.values.toList();
    _categoryNames = _getCategoryNames(_categoryList);
  }

  final _taskService = locator.get<TaskService>();
  final double _leftPadding = 13;
  late final Box<Task> taskBox;
  late final Box<Category> categoryBox;
  String? _selectedPriority;
  int? _selectedCategory;
  late final List<Category> _categoryList;
  late final List<String> _categoryNames;
  List<Task> _taskList = [];
  List<Task> _filteredTaskList = [];
  String? _taskCategory;
  final List<String> _priorityItems = ['High', 'Medium', 'Low'];
  DateTime _dateTime = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  String get taskCategory => _taskCategory ?? '';
  double get leftPadding => _leftPadding;
  DateTime get dateTime => _dateTime;
  List<String> get categoryNames => _categoryNames;
  List<String> get priorityItems => _priorityItems;
  List<Task> get filteredTaskList => _filteredTaskList;
  GlobalKey<FormState> get formKey => _formKey;

  void initialize(String category) {
    _taskCategory = category;
    fetchTasks();
  }

  void fetchTasks() {
    setBusy(true);
    _taskList = getCategoryTasks(taskCategory);
    _filteredTaskList = _taskList;
    setBusy(false);
  }

  List<String> _getCategoryNames(List<Category> categories) {
    return categories.map((category) => category.name).toList();
  }

  void getCategoryKey(String? newValue) {
    if (newValue == null) {
      _showToast('Please select a valid category.', Colors.red);
      return;
    }
    final matchingKey = categoryBox.keys.firstWhere(
      (key) => categoryBox.get(key)?.name == newValue,
      orElse: () => null,
    );
    if (matchingKey != null) {
      _selectedCategory = matchingKey;
      notifyListeners();
    } else {
      _showToast('Category "$newValue" not found.', Colors.red);
    }
  }

  void setSelectedPriority(String? newValue) {
    _selectedPriority = newValue!;
    notifyListeners();
  }

  String? validateInputLength(String? input) {
    return _taskService.validateInputLength(input);
  }

  String? validateEmptyField(String? input) {
    return _taskService.validateEmptyField(input);
  }

  void updateDate(DateTime? value) {
    _dateTime = value!;
    dateController.text = DateFormat('dd MMMM, y').format(_dateTime);
    notifyListeners();
  }

  void updateTime(TimeOfDay? newTime, String? timeStatus) {
    if (newTime != null) {
      if (timeStatus == 'start') {
        startTimeController.text = _formatTime(newTime);
      } else {
        endTimeController.text = _formatTime(newTime);
      }
      notifyListeners();
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour < 10 ? '0${time.hour}' : '${time.hour}';
    final minute = time.minute < 10 ? '0${time.minute}' : '${time.minute}';
    return '$hour:$minute hrs';
  }

  void updateTask(Task task) {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      _formKey.currentState?.save();
      final _updatedTask = task.copyWith(
          name: nameController.text,
          categoryKey: _selectedCategory,
          tacklingDate: _dateTime.toString(),
          startTime: startTimeController.text,
          endTime: endTimeController.text,
          priority: _selectedPriority);
      taskBox.put(task.key, _updatedTask);
      notifyListeners();
      _showToast('task updated successfully', Colors.green);
    }
  }

  void _showToast(String message, Color backgroundColor) {
    _taskService.showToast(message, backgroundColor);
  }

  Future<void> deleteTask(int taskKey) async {
    await taskBox.delete(taskKey);
    notifyListeners();
  }

  void handleCheckBoxChange(bool? value, Task task) {
    if (value == null) return;
    final updatedTask = task.copyWith(isFinished: value);
    taskBox.putAt(task.key, updatedTask);
    notifyListeners();
  }

  List<Task> getCategoryTasks(String taskCategory) {
    return taskBox.values
        .where(
            (task) => categoryBox.getAt(task.categoryKey)!.name == taskCategory)
        .toList();
  }

  void addTask() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      if (_selectedPriority == null || _selectedCategory == null) {
        _showToast('Please complete all fields.', Colors.red);
        return;
      }
      final newTask = Task(
        name: nameController.text.trim(),
        categoryKey: _selectedCategory!,
        tacklingDate: _dateTime.toString(),
        startTime: startTimeController.text.trim(),
        endTime: endTimeController.text.trim(),
        priority: _selectedPriority!,
      );
      taskBox.add(newTask);
      _resetForm();
      notifyListeners();
      _showToast('Task added successfully', Colors.green);
    }
  }

  void _resetForm() {
    nameController.clear();
    dateController.clear();
    startTimeController.clear();
    endTimeController.clear();
    _selectedPriority = null;
  }

  void filterTasks(String query) {
    query = query.toLowerCase();
    _filteredTaskList = query.isEmpty
        ? _taskList
        : _taskList.where((task) => task.name.toLowerCase().contains(query)).toList();
    notifyListeners();
  }

  Widget getPriorityIcon(String priority) {
    return _taskService.getPriorityIcon(priority);
  }

  Widget getDurationWidget(String date) {
    double fontSize = 14;
    DateTime parsedDate = DateTime.parse(date);
    DateTime today = DateTime.now();
    if (parsedDate.year == today.year &&
        parsedDate.month == today.month &&
        parsedDate.day == today.day) {
      return Text('Today',
          style: TextStyle(color: Colors.green, fontSize: fontSize));
    } else if (parsedDate.year == today.year &&
        parsedDate.month == today.month &&
        parsedDate.day == today.day + 1) {
      return Text('Tomorrow',
          style: TextStyle(color: Colors.amber, fontSize: fontSize));
    } else if (parsedDate.year == today.year &&
        parsedDate.month == today.month &&
        parsedDate.day == today.day - 1) {
      return Text('Yesterday',
          style: TextStyle(color: Colors.red, fontSize: fontSize));
    } else {
      return Text(
        DateFormat('dd MMMM, y').format(parsedDate),
        style: TextStyle(color: AppColors.primaryColor, fontSize: fontSize),
      );
    }
  }

  Widget buildTextFormField({
    required TextEditingController controller,
    required String? Function(String?)? validator,
    required String hintText,
    required String labelText,
    void Function()? onTap,
    Widget? suffixIcon
  }) {
    return TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          suffixIcon: suffixIcon,
          focusColor: AppColors.primaryColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
        ),
        onTap: onTap);
  }

  Widget buildDropdownFormField({
    required List<String> items,
    required String hintText,
    required String labelText,
    required void Function(String?)? onChanged,
    String? selectedValue,
  }) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      onChanged: onChanged,
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        focusColor: AppColors.primaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
      ),
      validator: (value) {
        if (value == null) {
          return 'Please select an option';
        }
        return null;
      },
    );
  }
}
