import 'package:flutter/material.dart';
import 'package:publist/constants.dart';
import 'package:publist/widgets/task_related_widgets/tasks_list.dart';
import 'package:publist/screens/add_task_screen.dart';
import 'package:provider/provider.dart';
import 'package:publist/models/task_data.dart';
import 'package:publist/enums.dart';
import 'package:intl/intl.dart';

class TodayScreen extends StatefulWidget {
  TodayScreen({@required this.now});
  final DateTime now;

  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  String displayedDate;

  @override
  void initState() {
    Provider.of<TaskData>(context, listen: false).getUserTasks();
    super.initState();
    getDate(widget.now);
  }

  void getDate(DateTime inputDate) {
    displayedDate = DateFormat.MMMEd().format(inputDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      floatingActionButton: FloatingActionButton(
          backgroundColor: kMainThemeColor,
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              context: context,
              builder: (BuildContext context) => SingleChildScrollView(
                  child: AddTaskScreen(role: Role.addTask)),
            );
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // showModalBottomSheet(
                    //   isScrollControlled: true,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(20),
                    //       topRight: Radius.circular(20),
                    //     ),
                    //   ),
                    //   context: context,
                    //   builder: (BuildContext context) => SingleChildScrollView(
                    //     child: DateSelection(),
                    //   ),
                    // );
                  },
                  child: Text(
                    displayedDate,
                    style: defaultTextStyle,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '${Provider.of<TaskData>(context).taskCount} Tasks',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          kDivider,
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TasksList(),
            ),
          ),
          kDivider,
        ],
      ),
    );
  }
}
