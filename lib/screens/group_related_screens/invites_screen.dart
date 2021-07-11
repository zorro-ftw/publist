import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:publist/constants.dart';
import 'package:provider/provider.dart';
import 'package:publist/models/user_group_data.dart';
import 'package:publist/widgets/group_related_widgets/user_groups_list.dart';
import 'package:publist/screens/group_related_screens/create_group_screen.dart';

class InvitesScreen extends StatefulWidget {
  static const String id = 'invites_screen';
  @override
  _InvitesScreenState createState() => _InvitesScreenState();
}

class _InvitesScreenState extends State<InvitesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserGroupData>(context, listen: false).getUserGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
    );
  }
}
