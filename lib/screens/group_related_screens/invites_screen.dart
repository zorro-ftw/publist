import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publist/constants.dart';
import 'package:provider/provider.dart';
import 'package:publist/firebase_services/data_service.dart';
import 'package:publist/models/user_invite_data.dart';
import 'package:publist/widgets/group_related_widgets/user_invites_list.dart';

class InvitesScreen extends StatefulWidget {
  @override
  _InvitesScreenState createState() => _InvitesScreenState();
}

class _InvitesScreenState extends State<InvitesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserInviteData>(context, listen: false).getUserInvites();
  }

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
      backgroundColor: Colors.white,
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
                  'Invites',
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
                    '${Provider.of<UserInviteData>(context).inviteCount} Invites',
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
              child: UserInvitesList(),
            ),
          ),
        ],
      ),
    );
  }
}
