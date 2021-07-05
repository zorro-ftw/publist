import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:publist/constants.dart';
import 'package:publist/models/user_group_data.dart';

class CreateGroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newGroupTitle;
    String newGroupDescription;

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Create Group',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Enter group name'),
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newGroupTitle = newText;
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter group description',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: kMainThemeColor, width: 2),
                ),
              ),
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newGroupDescription = newText;
              },
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.orange),
              child: Text(
                'Create',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (newGroupTitle != null) {
                  Provider.of<UserGroupData>(context, listen: false)
                      .addGroup(newGroupTitle, newGroupDescription);

                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
