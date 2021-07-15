import 'package:flutter/material.dart';
import 'package:publist/screens/login_screen.dart';
import 'package:publist/screens/main_screen.dart';
import 'package:publist/firebase_services/auth_service.dart';
import 'package:publist/screens/registration_screen.dart';
import 'package:publist/screens/group_related_screens/invites_screen.dart';
import 'package:publist/screens/profile_screen.dart';

enum Menu { ProfileScreen, InvitesScreen, selfStarter, LogOut }

class PopUpButton extends StatefulWidget {
  @override
  _PopUpButtonState createState() => _PopUpButtonState();
}

class _PopUpButtonState extends State<PopUpButton> {
  final _auth = AuthService();
  var _selection;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
      child: Icon(Icons.menu),
      onSelected: (Menu result) {
        setState(
          () {
            _selection = result;
            if (_selection == Menu.LogOut) {
              _auth.logout();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            } else if (_selection == Menu.InvitesScreen) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return InvitesScreen();
                  },
                ),
              );
            } else if (_selection == Menu.ProfileScreen) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProfileScreen();
                  },
                ),
              );
            }
          },
        );
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
        const PopupMenuItem<Menu>(
          value: Menu.ProfileScreen,
          child: Text('Profile'),
        ),
        const PopupMenuItem<Menu>(
          value: Menu.InvitesScreen,
          child: Text('Invites'),
        ),
        // const PopupMenuItem<Menu>(
        //   value: Menu.selfStarter,
        //   child: Text('Denemeee'),
        // ),
        const PopupMenuItem<Menu>(
          value: Menu.LogOut,
          child: Text('Log Out'),
        ),
      ],
    );
  }
}
