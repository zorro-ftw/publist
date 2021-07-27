import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publist/constants.dart';
import 'package:publist/models/group_data.dart';
import 'package:provider/provider.dart';
import 'package:publist/models/user_invite_data.dart';
import 'package:publist/widgets/group_related_widgets/group_member_list.dart';

class MemberManagementScreen extends StatelessWidget {
  final String currentGroupID;
  final String currentGroupName;

  MemberManagementScreen({this.currentGroupName, this.currentGroupID});

  @override
  Widget build(BuildContext context) {
    String newUserEmail;

    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 110),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${Provider.of<GroupData>(context).memberCount} Members',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Container(
            decoration: BoxDecoration(
                color: Provider.of<GroupData>(context).isCurrentUserAdmin
                    ? kMainThemeColor
                    : kDisabledButtonFillColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            constraints: BoxConstraints(maxWidth: 250.0, minHeight: 40.0),
            margin: EdgeInsets.all(8),
            child: TextButton(
              onPressed: Provider.of<GroupData>(context).isCurrentUserAdmin

                  ///currentUser admin değilse onpressed boş bir fonksiyon
                  ? () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                elevation: 10,
                                title: Text('Enter user e-mail to invite'),
                                content: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: true,
                                  textAlign: TextAlign.center,
                                  onChanged: (newText) {
                                    newUserEmail = newText;
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    // style: TextButton.styleFrom(
                                    //     backgroundColor: Colors.orange),
                                    onPressed: () async {
                                      await Provider.of<UserInviteData>(context,
                                              listen: false)
                                          .inviteUser(
                                              userEmail: newUserEmail,
                                              groupID: currentGroupID,
                                              groupName: currentGroupName);

                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: Text(
                                      'Invite',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          barrierDismissible: true);
                    }
                  : () {}

              /// Yukarıda bahsedilen boş fonksiyon
              ,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 5),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Invite a member',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.person_add,
                        color: Colors.white,
                        size: 26,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          kDivider,
          Expanded(
            child: Container(
              child: GroupMemberList(),
            ),
          )
        ],
      ),
    );
  }
}
