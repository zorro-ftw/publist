import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:publist/models/group_task_data.dart';

class AddGroupTaskScreen extends StatelessWidget {
  final String groupID;

  AddGroupTaskScreen({this.groupID});

  @override
  Widget build(BuildContext context) {
    String inputText, header, buttonText;

    header = 'Add Group Task';
    buttonText = 'Add';

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
              header,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                inputText = newText;
              },
            ),
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.orange),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if (inputText != null) {
                    await Provider.of<GroupTaskData>(context, listen: false)
                        .addTask(newTaskTitle: inputText, groupID: groupID);
                    Navigator.pop(context);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
