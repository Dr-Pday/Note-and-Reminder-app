import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_application/data/task.dart';

import 'package:note_application/widget/task_type_item.dart';
import 'package:note_application/utility/utility.dart';
import 'package:time_pickerr/time_pickerr.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  final TextEditingController controllerTaskTitle = TextEditingController();
  final TextEditingController controllerTaskSubTitle = TextEditingController();

  final box = Hive.box<Task>('taskBox');

  bool checkTask = false;
  int _selectedTaskItem = 0;
  Color color = Colors.transparent;

  DateTime? _time;
  @override
  void initState() {
    super.initState();
    negahban1.addListener(() {});
    negahban2.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff18DAA3),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'تسک جدید',
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
                  height: 25,
                ),
                _getTextField(negahban1, 1, 'عنوان', controllerTaskTitle),
                SizedBox(height: 30),
                _getTextField(negahban2, 2, 'توضیحات', controllerTaskSubTitle),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: CustomHourPicker(
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
                          color: Color(0xff18DAA3),
                          index: index,
                          selectedTaskItem: _selectedTaskItem,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'کنسل',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SM',
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        minimumSize: Size(150, 50),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (controllerTaskTitle.text == '' &&
                            controllerTaskSubTitle.text == '') {
                        } else {
                          String taskTitle = controllerTaskTitle.text;
                          String taskSubTitle = controllerTaskSubTitle.text;
                          addTask(taskTitle, taskSubTitle, _selectedTaskItem);
                        }
                        Navigator.pop(context);
                      },
                      child: Text(
                        'اضافه',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SM',
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff18DAA3),
                        minimumSize: Size(150, 50),
                      ),
                    ),
                  ],
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
            width: 150,
            height: 50,
            color: Color(0xff18DAA3).withOpacity(0.6),
            child: Text(
              'زمان ذخیره شد',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  deleteTheSave() {}

  addTask(String taskTitle, String taskSubTitle, index) {
    var task = Task(
        title: taskTitle,
        subTitle: taskSubTitle,
        time: _time!,
        taskType: getTaskTypeList()[_selectedTaskItem]);
    box.add(task);
  }

  @override
  void dispose() {
    super.dispose();
    negahban1.dispose();
    negahban2.dispose();
  }
}

// ignore: must_be_immutable

Widget _getTextField(
  negahban,
  int textLines,
  String labelName,
  TextEditingController controller,
) {
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
            color: negahban.hasFocus ? Color(0xff18DAA3) : Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Color(0xffC5C5C5), width: 3.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(
              width: 3,
              color: Color(0xff18DAA3),
            ),
          ),
        ),
      ),
    ),
  );
}
