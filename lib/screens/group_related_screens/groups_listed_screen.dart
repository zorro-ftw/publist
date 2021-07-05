import 'package:flutter/material.dart';
import 'package:publist/constants.dart';
import 'package:provider/provider.dart';
import 'package:publist/models/user_group_data.dart';
import 'package:publist/widgets/groups_list.dart';

class GroupsListedScreen extends StatefulWidget {
  @override
  _GroupsListedScreenState createState() => _GroupsListedScreenState();
}

class _GroupsListedScreenState extends State<GroupsListedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      floatingActionButton: FloatingActionButton(
          backgroundColor: kMainThemeColor,
          child: Icon(Icons.add),
          onPressed: () {
            //TODO - Yeni grup kurma fonksiyonu eklenecek. user_group_data'daki addGroup fonksiyonu da burada çağırılacak.
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
                    'My Groups',
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
              child: GroupsList(),
            ),
          ),
          kDivider,
        ],
      ),
    );
  }
}
