import 'package:flutter/material.dart';
import 'package:publist/constants.dart';
import 'package:publist/models/group_data.dart';
import 'package:provider/provider.dart';
import 'package:publist/widgets/group_related_widgets/group_member_list.dart';

class MemberManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                color: kMainThemeColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            constraints: BoxConstraints(maxWidth: 250.0, minHeight: 40.0),
            margin: EdgeInsets.all(8),
            child: TextButton(
              onPressed: () {
                //TODO - Davet gönderme işlemi buradan yapılacak
              },
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
