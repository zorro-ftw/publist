import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// user_groups_list dosyasının listeleme yaparken kullandığı group tile Widget'ı.

class InviteTile extends StatelessWidget {
  final String groupTitle;
  final String senderName;
  final Function onAccept;
  final Function onReject;

  InviteTile({this.groupTitle, this.onAccept, this.senderName, this.onReject});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.20,
      secondaryActions: [
        IconSlideAction(
          caption: 'Accept',
          color: Colors.green.shade600,
          icon: Icons.check,
          onTap: onAccept,
        ),
        IconSlideAction(
          caption: 'Reject',
          color: Colors.redAccent,
          icon: Icons.close,
          onTap: onReject,
        ),
      ],
      child: ListTile(
        leading: Icon(Icons.insert_invitation_outlined),
        trailing: Icon(Icons.arrow_left_outlined),
        title: Text(
          '$senderName invites you to join $groupTitle',
        ),
      ),
    );
  }
}

// Checkbox(
// activeColor: Color(0xFFCE9F35),
// value: isChecked,
// onChanged: checkboxCallback,
