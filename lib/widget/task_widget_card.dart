import 'package:flutter/material.dart';
import 'package:note_application/data/task.dart';
import 'package:note_application/screens/edit_task_screen.dart';



// ignore: must_be_immutable
class TaskWidgetCard extends StatefulWidget {
  TaskWidgetCard({super.key, required this.task});
  Task task;
  @override
  State<TaskWidgetCard> createState() => _TaskWidgetCardState();
}

class _TaskWidgetCardState extends State<TaskWidgetCard> {
  bool isBoxChecked = false;
  bool wellDone = false;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    isBoxChecked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return _getTasks(widget.task);
  }

  Widget _getTasks(task) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isBoxChecked = !isBoxChecked;
          wellDone = !wellDone;
          widget.task.isDone = isBoxChecked;
          widget.task.save();
        });
      },
      child: _getCard(task),
    );
  }

  Widget _getCard(task) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      height: 132,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _getOptions(task),
                  _getButtoms(task),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.task.taskType.image,
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getOptions(task) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 1.2,
          child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              activeColor: Colors.blueAccent.withOpacity(0.9),
              value: isBoxChecked,
              onChanged: (value) {}),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.task.title,
                style: TextStyle(
                  fontFamily: 'SM',
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[700],
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.task.subTitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(fontFamily: 'SM', color: Colors.black38),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _getButtoms(task) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(16),
          ),
          height: 40,
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${getHourUner10(widget.task.time)} : ${getMinUner10(widget.task.time)}',
                style: TextStyle(
                    color: Color(0xff18DAA3),
                    fontSize: 14,
                    fontFamily: 'SM',
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20,
                height: 20,
                child: Image.asset(
                  'images/icon_time.png',
                  color: Color(0xff18DAA3),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(task: widget.task),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            height: 40,
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'ویرایش',
                  style: TextStyle(
                      color: Colors.blueAccent, fontSize: 14, fontFamily: 'SM'),
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    'images/icon_edit.png',
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String? getMinUner10(DateTime time) {
    var min = time.minute + 1;
    if (min <= 10) {
      return '0$min';
    } else {
      return '${time.minute}';
    }
  }

  String? getHourUner10(DateTime time) {
    var hour = time.hour + 1;
    if (hour <= 10) {
      return '0$hour';
    } else {
      return '${time.hour}';
    }
  }
}
