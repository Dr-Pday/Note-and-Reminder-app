

import 'package:note_application/data/task_type.dart';
import 'package:note_application/data/type_enum.dart';

List<TaskType> getTaskTypeList() {
  var list = [
    TaskType(
      image: 'images/meditate.png',
      title: 'تمرکز',
      taskTypeEnum: TaskTypeEnum.foucs,
    ),
    TaskType(
      image: 'images/social_frends.png',
      title: 'قرار',
      taskTypeEnum: TaskTypeEnum.date,
    ),
    TaskType(
      image: 'images/hard_working.png',
      title: 'کار',
      taskTypeEnum: TaskTypeEnum.working,
    ),
  ];
  return list;
}
