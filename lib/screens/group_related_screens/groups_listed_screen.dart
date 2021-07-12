import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:publist/constants.dart';
import 'package:provider/provider.dart';
import 'package:publist/models/user_group_data.dart';
import 'package:publist/widgets/group_related_widgets/user_groups_list.dart';
import 'package:publist/screens/group_related_screens/create_group_screen.dart';

class GroupsListedScreen extends StatefulWidget {
  @override
  _GroupsListedScreenState createState() => _GroupsListedScreenState();
}

class _GroupsListedScreenState extends State<GroupsListedScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserGroupData>(context, listen: false).getUserGroups();
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
                child: CreateGroupScreen(),
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
                Text(
                  'My Groups',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '${Provider.of<UserGroupData>(context).groupCount} Groups',
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
              child: UserGroupsList(),
            ),
          ),
          kDivider,
        ],
      ),
    );
  }
}
