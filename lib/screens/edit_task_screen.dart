import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_application/screens/add_task_screen.dart';
import 'package:note_application/data/task.dart';

import 'package:note_application/widget/task_type_item.dart';
import 'package:note_application/utility/utility.dart';
import 'package:time_pickerr/time_pickerr.dart';

// ignore: must_be_immutable
class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});
  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerTaskSubTitle;

  final box = Hive.box<Task>('taskBox');
  DateTime? _time;
  bool checkTask = false;

  int _selectedTaskItem = 0;
  Color color = Colors.transparent;

  @override
  void initState() {
    super.initState();
    controllerTaskTitle = TextEditingController(text: widget.task.title);
    controllerTaskSubTitle = TextEditingController(text: widget.task.subTitle);
    negahban1.addListener(() {});
    negahban2.addListener(() {});

    var index = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });

    _selectedTaskItem = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ویرایش',
          style: TextStyle(
              fontFamily: 'SM',
              fontSize: 18,
              color: Colors.blueGrey[800],
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: 840,
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                _getTextField(negahban1, 1, 'عنوان تسک', controllerTaskTitle!),
                SizedBox(height: 30),
                _getTextField(negahban2, 2, 'توضیحات', controllerTaskSubTitle!),
                CustomHourPicker(
                  titleStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                  title: 'زمان را انتخاب کنید',
                  elevation: 1,
                  negativeButtonText: 'حذف کردن',
                  negativeButtonStyle: TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                  positiveButtonText: 'انتخاب زمان',
                  positiveButtonStyle: TextStyle(
                      color: Color(0xff18DAA3), fontWeight: FontWeight.bold),
                  onPositivePressed: (context, time) {
                    _time = time;
                    setState(() {
                      checkTask = true;
                    });
                  },
                  onNegativePressed: (context) {},
                ),
                _getTimeText(),
                SizedBox(height: 10),
                Container(
                  height: 175,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getTaskTypeList().length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedTaskItem = index;
                          });
                        },
                        child: getTaskTypeItemList(
                          taskType: getTaskTypeList()[index],
                          color: Colors.blueAccent,
                          index: index,
                          selectedTaskItem: _selectedTaskItem,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getbuttom(Colors.redAccent, 'حذف'),
                      SizedBox(width: 20),
                      getbuttom(Colors.blueAccent, 'ویرایش'),
                      SizedBox(width: 20),
                      getbuttom(Color(0xff18DAA3), 'کنسل'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getTimeText() {
    return Visibility(
      visible: checkTask,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 50,
            color: Colors.blueAccent.withOpacity(0.6),
            child: Text(
              'زمان ذخیره شد',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Widget getbuttom(Color color, String title) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          String taskTitle = controllerTaskTitle!.text;
          String taskSubTitle = controllerTaskSubTitle!.text;
          editTask(
            taskTitle,
            taskSubTitle,
          );
          Navigator.pop(context);
        },
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, fontFamily: 'SM', fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: Size(150, 60),
        ),
      ),
    );
  }

  editTask(String taskTitle, String taskSubTitle) {
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSubTitle;
    _time == null ? _time == DateTime.now() : widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[_selectedTaskItem];

    widget.task.save();
  }

  deleteTask(String taskTitle, String taskSubTitle) {
    widget.task.delete();
  }

  @override
  void dispose() {
    super.dispose();
    negahban1.dispose();
    negahban2.dispose();
  }
}

Widget _getTextField(negahban, int textLines, String labelName,
    TextEditingController controller) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 44.0),
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: controller,
        maxLines: textLines,
        focusNode: negahban,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: labelName,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'SM',
            fontSize: 14,
            color: negahban.hasFocus ? Colors.blueAccent : Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Color(0xffC5C5C5), width: 3.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 3,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    ),
  );
}
