import 'package:flutter/material.dart';
import 'package:publist/widgets/tasks_list.dart';
import 'package:publist/screens/add_task_screen.dart';
import 'package:provider/provider.dart';
import 'package:publist/models/task_data.dart';
import 'package:publist/services/date_selection_service.dart';
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
    super.initState();
    getDate(widget.now);
  }

  void getDate(DateTime inputDate) {
    displayedDate = DateFormat.MMMEd().format(inputDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFCE9F35),
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
                child: AddTaskScreen(),
              ),
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
                SizedBox(
                  height: 10.0,
                ),
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
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                    ),
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
          const Divider(
            color: Color(0xFFBDBDBD),
            height: 10,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: TasksList(),
            ),
          ),
          const Divider(
            color: Color(0xFFBDBDBD),
            height: 10,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
        ],
      ),
    );
  }
}
