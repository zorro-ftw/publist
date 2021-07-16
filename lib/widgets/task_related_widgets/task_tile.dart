import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:publist/enums.dart';

class TaskTile extends StatelessWidget {
  final TaskStatus taskStatus;
  final String taskTitle;
  final Function triggerSuccess;
  final Function triggerFail;
  final Function triggerDelete;
  final Function triggerActivate;
  // final trailingIcon = if(taskStatus==TaskStatus.active)

  TaskTile(
      {this.taskStatus,
      this.taskTitle,
      this.triggerSuccess,
      this.triggerFail,
      this.triggerDelete,
      this.triggerActivate});

  List<Widget> getActions(TaskStatus taskStatus) {
    if (taskStatus == TaskStatus.active) {
      return <Widget>[
        IconSlideAction(
            caption: 'Success',
            color: Colors.green.shade600,
            icon: Icons.check,
            onTap: triggerSuccess),
        IconSlideAction(
          caption: 'Fail',
          color: Colors.redAccent,
          icon: Icons.close,
          onTap: triggerFail,
        ),
        IconSlideAction(
          foregroundColor: Colors.white,
          caption: 'Delete',
          color: Colors.amber.shade800,
          icon: Icons.delete,
          onTap: triggerDelete,
        ),
      ];
    } else if (taskStatus == TaskStatus.success) {
      return <Widget>[
        IconSlideAction(
          caption: 'Fail',
          color: Colors.redAccent,
          icon: Icons.close,
          onTap: triggerFail,
        ),
        IconSlideAction(
            caption: 'Activate again',
            color: Colors.grey.shade600,
            icon: Icons.refresh,
            onTap: triggerActivate),
      ];
    } else {
      return <Widget>[
        IconSlideAction(
            caption: 'Success',
            color: Colors.green.shade600,
            icon: Icons.check,
            onTap: triggerSuccess),
        IconSlideAction(
            caption: 'Activate again',
            color: Colors.grey.shade600,
            icon: Icons.refresh,
            onTap: triggerActivate),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: taskStatus == TaskStatus.active ? 0.20 : 0.30,
      actions: [
        IconSlideAction(
          caption: 'Reminder',
          color: Colors.lightBlue,
          icon: Icons.alarm,
          foregroundColor: Colors.white,
        )
      ],
      secondaryActions: getActions(taskStatus),
      child: ListTile(
        title: Text(
          taskTitle,
          style: TextStyle(
              decoration: taskStatus == TaskStatus.active
                  ? null
                  : TextDecoration.lineThrough),
        ),
        trailing: getTrailingIcon(taskStatus),
        leading: Icon(Icons.arrow_right_outlined),
      ),
    );
  }
}

//Status'e göre gösterilecek icon'u belirleyen metod.
Widget getTrailingIcon(TaskStatus taskStatus) {
  if (taskStatus == TaskStatus.active) {
    return Icon(Icons.arrow_left_outlined);
  } else if (taskStatus == TaskStatus.success) {
    return Icon(
      Icons.check,
      color: Colors.green.shade600,
    );
  } else {
    return Icon(
      Icons.close,
      color: Colors.redAccent,
    );
  }
}

// Checkbox(
// activeColor: Color(0xFFCE9F35),
// value: isChecked,
// onChanged: checkboxCallback,
