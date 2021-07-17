import 'package:flutter/material.dart';

class GroupMemberTile extends StatelessWidget {
  final String memberName;
  final bool isAdmin;
  GroupMemberTile({this.memberName, this.isAdmin});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.person),
        title: Text(memberName),
        trailing: isAdmin
            ? Text(
                'Admin',
                style: TextStyle(
                    color: Colors.green.shade700, fontWeight: FontWeight.bold),
              )
            : null);
  }
}
