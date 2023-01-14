import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/data/task.dart';
import 'package:note_application/data/task_type.dart';
import 'package:note_application/data/type_enum.dart';
import 'package:note_application/screens/home_screen.dart';

import 'screens/add_task_screen.dart';


void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskTypeAdapter());
Hive.registerAdapter(TaskTypeEnumAdapter());
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');

  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
