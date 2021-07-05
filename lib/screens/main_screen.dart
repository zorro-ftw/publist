import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:publist/constants.dart';
import 'package:publist/screens/today_screen.dart';
import 'package:publist/screens/group_related_screens/groups_listed_screen.dart';
import 'package:publist/models/user_group_data.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(85),
            child: AppBar(
              backgroundColor: kMainThemeColor,
              bottom: TabBar(
                indicatorColor: Colors.yellow,
                indicatorWeight: 3,
                tabs: [
                  Tab(
                    text: 'Tasks',
                  ),
                  Tab(
                    text: 'Groups',
                  ),
                  Tab(
                    text: 'Lists',
                  ),
                ],
              ),
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
          body: TabBarView(
            children: [
              TodayScreen(
                now: DateTime.now(),
              ),
              // GroupScreen(),
              ChangeNotifierProvider(
                create: (context) => UserGroupData(),
                child: GroupsListedScreen(),
              ),
              Icon(Icons.directions_bike)
            ],
          ),
        ),
      ),
    );
  }
}
