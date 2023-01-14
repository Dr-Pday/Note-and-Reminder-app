import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_application/screens/add_task_screen.dart';
import 'package:note_application/data/task.dart';

import 'package:note_application/widget/task_widget_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
 
class _HomeScreenState extends State<HomeScreen> {
  var taskBox = Hive.box<Task>('taskBox');
  bool isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff18DAA3),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'یادآور شخصی',
            style: TextStyle(
                fontFamily: 'SM',
                fontSize: 20,
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.bold),
          ),
        ),
        floatingActionButton: Visibility(
          visible: isFabVisible,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return AddTaskScreen();
                  },
                ),
              );
            },
            backgroundColor: Color(0xff18DAA3),
            child: Image.asset('images/icon_add.png'),
          ),
        ),
        backgroundColor: Color(0xffE5E5E5),
        body: ValueListenableBuilder(
            valueListenable: taskBox.listenable(),
            builder: (context, value, child) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  setState(() {
                    if (notification.direction == ScrollDirection.forward) {
                      isFabVisible = true;
                    }
                    if (notification.direction == ScrollDirection.reverse) {
                      isFabVisible = false;
                    }
                  });

                  return true;
                },
                child: ListView.builder(
                  itemCount: taskBox.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    var task = taskBox.values.toList()[index];
                    return getListItem(task);
                  },
                ),
              );
            }),
      ),
    );
  }

  Widget getListItem(Task task) {
    return Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          task.delete();
        },
        child: TaskWidgetCard(task: task));
  }
}
