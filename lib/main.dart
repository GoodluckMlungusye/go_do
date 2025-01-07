import 'package:flutter/material.dart';
import 'package:go_do/app/app.dart';
import 'package:go_do/models/Category.dart';
import 'package:go_do/models/Task.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:go_do/services/service_injector/dependency_container.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await path.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.initFlutter('godo_db');

  Hive.registerAdapter<Task>(TaskAdapter());
  Hive.registerAdapter<Category>(CategoryAdapter());

  await Hive.openBox<Task>('task');
  await Hive.openBox<Category>('category');

  setup();
  runApp(const App());
}
