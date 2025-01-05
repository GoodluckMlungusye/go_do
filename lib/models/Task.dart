import 'package:hive_flutter/hive_flutter.dart';
part 'Task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int categoryKey;
  @HiveField(2)
  final String tacklingDate;
  @HiveField(3)
  final String startTime;
  @HiveField(4)
  final String endTime;
  @HiveField(5)
  final String priority;
  @HiveField(6)
  late bool isFinished;

  Task({
    required this.name,
    required this.categoryKey,
    required this.tacklingDate,
    required this.startTime,
    required this.endTime,
    required this.priority,
    this.isFinished = false,
  });

  Task copyWith({
    String? name,
    int? categoryKey,
    String? tacklingDate,
    String? startTime,
    String? endTime,
    String? priority,
    bool? isFinished,
  }) {
    return Task(
      name: name ?? this.name,
      categoryKey: categoryKey ?? this.categoryKey,
      tacklingDate: tacklingDate ?? this.tacklingDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      priority: priority ?? this.priority,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}
