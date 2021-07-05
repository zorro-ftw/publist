import 'package:flutter/material.dart';
import 'package:publist/models/group.dart';
import 'package:publist/constants.dart';

class GroupMainScreen extends StatefulWidget {
  static const String id = 'group_main_screen';

  final String groupName;
  GroupMainScreen({this.groupName});

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
            //TODO Yeni grup listesi oluşturma eklenecek.
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
                    Text(
                      widget.groupName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: kMainThemeColor,
                          child: Icon(
                            Icons.group,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CircleAvatar(
                          backgroundColor: kMainThemeColor,
                          child: Icon(
                            Icons.settings,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        CircleAvatar(
                          backgroundColor: kMainThemeColor,
                          child: Icon(
                            Icons.chat,
                            size: 24,
                            color: Colors.white,
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
                      '2 Lists',
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
            ),
          ),
        ],
      ),
    );
  }
}
