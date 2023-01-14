import 'package:hive/hive.dart';

import 'type_enum.dart';

part 'task_type.g.dart';

@HiveType(typeId: 1)
class TaskType {
  TaskType({
    required this.image,
    required this.title,
    required this.taskTypeEnum,
  });
  @HiveField(0)
  String image;

  @HiveField(1)
  String title;

  @HiveField(2)
  TaskTypeEnum taskTypeEnum;
}
