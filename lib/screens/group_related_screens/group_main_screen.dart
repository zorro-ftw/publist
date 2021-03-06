import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:publist/constants.dart';
import 'package:publist/models/group_data.dart';
import 'package:publist/screens/chat_screen.dart';
import 'package:publist/screens/group_related_screens/add_group_task_screen.dart';
import 'package:publist/screens/group_related_screens/member_management_screen.dart';
import 'package:publist/widgets/group_related_widgets/group_main_task_list.dart';
import 'package:publist/screens/group_related_screens/group_settings_screen.dart';
import 'package:publist/models/group_task_data.dart';


class GroupMainScreen extends StatefulWidget {
  static const String id = 'group_main_screen';

  final String groupID;
  GroupMainScreen({this.groupID});

  @override
  _GroupMainScreenState createState() => _GroupMainScreenState();
}

class _GroupMainScreenState extends State<GroupMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(85),
        child: AppBar(
          backgroundColor: kMainThemeColor,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'PUBLIST',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          centerTitle: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: kMainThemeColor,
          child: Icon(Icons.add),
          onPressed: () {
            //TODO Yeni grup task oluşturma eklenecek.

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
                  child: AddGroupTaskScreen(
                groupID: widget.groupID,
              )),
            );
          }),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 18, right: 10, top: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 230),
                      child: Text(
                        Provider.of<GroupData>(context).getGroupName(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: kMainThemeColor,
                            child: Icon(
                              Icons.group,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              context: context,
                              builder: (BuildContext context) =>
                                  SingleChildScrollView(
                                child: MemberManagementScreen(
                                  currentGroupName:
                                      Provider.of<GroupData>(context)
                                          .getGroupName(),
                                  currentGroupID:
                                      Provider.of<GroupData>(context)
                                          .getGroupID(),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: kMainThemeColor,
                            child: Icon(
                              Icons.settings,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              context: context,
                              builder: (BuildContext context) =>
                                  SingleChildScrollView(
                                child: GroupSettingsScreen(
                                  currentGroupName:
                                      Provider.of<GroupData>(context)
                                          .getGroupName(),
                                  currentGroupID:
                                      Provider.of<GroupData>(context)
                                          .getGroupID(),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CircleAvatar(
                          backgroundColor: kMainThemeColor,
                          child: IconButton(
                            icon: Icon(
                              Icons.chat,
                              size: 24,
                              color: Colors.white,
                            ),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                    ChatScreen(),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${Provider.of<GroupTaskData>(context).taskCount} Tasks',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          kDivider,
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: GroupMainTaskList(),
            ),
          ),
        ],
      ),
    );
  }
}
