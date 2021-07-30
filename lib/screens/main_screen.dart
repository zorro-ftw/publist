import 'package:flutter/material.dart';
import 'package:publist/constants.dart';
import 'package:publist/screens/today_screen.dart';
import 'package:publist/screens/group_related_screens/groups_listed_screen.dart';
import 'package:publist/components/popup_button.dart';

enum Menu { ProfileScreen, InviteScreen, selfStarter, LogOut }

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
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(85),
            child: AppBar(
              leading: PopUpButton(),
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
              GroupsListedScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
