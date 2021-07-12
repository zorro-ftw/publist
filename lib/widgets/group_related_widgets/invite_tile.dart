import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// user_groups_list dosyasının listeleme yaparken kullandığı group tile Widget'ı.

class InviteTile extends StatelessWidget {
  final String groupTitle;
  final String senderName;
  final String groupDescription;
  final Function onTapCallback;

  InviteTile(
      {this.groupTitle,
      this.groupDescription,
      this.onTapCallback,
      this.senderName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTapCallback,
      leading: Icon(Icons.insert_invitation_outlined),
      title: Text(
        '$senderName invites you to join $groupTitle',
      ),
      subtitle: groupDescription == null ? null : Text(groupDescription),
    );
  }
}

// Checkbox(
// activeColor: Color(0xFFCE9F35),
// value: isChecked,
// onChanged: checkboxCallback,
