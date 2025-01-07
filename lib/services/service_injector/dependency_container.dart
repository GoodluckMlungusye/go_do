import 'package:get_it/get_it.dart';
import 'package:go_do/services/task_service.dart';

final locator = GetIt.instance;

void setup(){
  locator.registerLazySingleton<TaskService>(() => TaskService());
}