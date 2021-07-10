import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// user_groups_list dosyasının listeleme yaparken kullandığı group tile Widget'ı.

class GroupTile extends StatelessWidget {
  final String groupTitle;
  final String groupDescription;
  final Function onTapCallback;
  GroupTile({this.groupTitle, this.groupDescription, this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTapCallback,
      leading: Icon(CupertinoIcons.person_3_fill),
      title: Text(
        groupTitle,
      ),
      subtitle: groupDescription == null ? null : Text(groupDescription),
    );
  }
}

// Checkbox(
// activeColor: Color(0xFFCE9F35),
// value: isChecked,
// onChanged: checkboxCallback,
