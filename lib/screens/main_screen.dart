import 'package:flutter/material.dart';

import 'package:publist/screens/today_screen.dart';

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
          appBar: AppBar(
            backgroundColor: Color(0xFFCE9F35),
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
            title: Text(
              'PUBLIST',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              TodayScreen(
                now: DateTime.now(),
              ),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
