import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:publist/screens/group_related_screens/group_main_screen.dart';

class GroupListTile extends StatefulWidget {
  final String listTitle;

  final Function onTapCallback;
  GroupListTile({this.listTitle, this.onTapCallback});

  @override
  _GroupListTileState createState() => _GroupListTileState();
}

class _GroupListTileState extends State<GroupListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onTapCallback,
      leading: Icon(CupertinoIcons.list_bullet),
      title: Text(
        widget.listTitle,
      ),
    );
  }
}

// Checkbox(
// activeColor: Color(0xFFCE9F35),
// value: isChecked,
// onChanged: checkboxCallback,
