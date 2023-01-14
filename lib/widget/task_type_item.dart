import 'package:flutter/material.dart';
import 'package:note_application/data/task_type.dart';


class getTaskTypeItemList extends StatelessWidget {
  getTaskTypeItemList(
      {required this.taskType,
      required this.color,
      required this.index,
      required this.selectedTaskItem});
  Color color;
  TaskType taskType;
  int index;
  int selectedTaskItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: (selectedTaskItem == index)
                ? color
                : Colors.grey.withOpacity(0.4),
            width: 2),
        color: (selectedTaskItem == index)
            ? color.withOpacity(0.7)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      width: 135,
      child: Column(
        children: [
          SizedBox(
            height: 110,
            width: 110,
            child: Image.asset(taskType.image),
          ),
          Text(
            taskType.title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: selectedTaskItem == index ? 18 : 12,
                color: selectedTaskItem == index ? Colors.white : Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
