import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:publist/screens/group_related_screens/group_main_screen.dart';

class GroupTile extends StatefulWidget {
  final String groupTitle;
  final String groupDescription;
  final Function onTapCallback;
  GroupTile({this.groupTitle, this.groupDescription, this.onTapCallback});

  @override
  _GroupTileState createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTapCallback,
      leading: Icon(CupertinoIcons.person_3_fill),
      title: Text(
        widget.groupTitle,
      ),
      subtitle: widget.groupDescription == null
          ? null
          : Text(widget.groupDescription),
    );
  }
}

// Checkbox(
// activeColor: Color(0xFFCE9F35),
// value: isChecked,
// onChanged: checkboxCallback,
