import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:publist/enums.dart';

class TaskTile extends StatelessWidget {
  final TaskStatus taskStatus;
  final String taskTitle;
  final Function triggerSuccess;
  final Function triggerFail;
  final Function triggerDelete;
  final Function triggerActivate;
  final Function setDateTime;
  final FlutterLocalNotificationsPlugin fltrNotification=FlutterLocalNotificationsPlugin();


  Future _showNotificaton(DateTime dateTime) async {
    var androidDetails=new AndroidNotificationDetails("channelID", "channelName", "channelDescription",importance: Importance.max);
    var iosDetails=new IOSNotificationDetails();
    var generalNotificationDetails=new NotificationDetails(android:androidDetails,iOS: iosDetails);
    var time2 = tz.TZDateTime(
      tz.local,
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
    );
    await fltrNotification.zonedSchedule(0, "$taskTitle", "Time for $taskTitle", time2, generalNotificationDetails,  androidAllowWhileIdle: true);
  }
  Future pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 3),
        lastDate: DateTime(DateTime.now().year + 3),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.orange,
                primaryColorDark: Colors.orange,
                accentColor: Colors.orange,
              ),
              dialogBackgroundColor:Colors.white,
            ),
            child: child,
          );
        },
    );
    if (date == null) return;
    final time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.fromSwatch(
                  primarySwatch: Colors.orange,
                  primaryColorDark: Colors.orange,
                  accentColor: Colors.orange,
                ),
                dialogBackgroundColor:Colors.white,
              ),
              child: child,
            );
          },);
    if (time == null) return;
    DateTime dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    _showNotificaton(dateTime);
    setDateTime(dateTime);
  }

  TaskTile(
      {this.taskStatus,
      this.taskTitle,
      this.triggerSuccess,
      this.triggerFail,
      this.triggerDelete,
      this.triggerActivate,
      this.setDateTime});

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
          caption: 'Attachment',
          color: Colors.blueGrey,
          icon: Icons.attach_file,
          foregroundColor: Colors.white,
        ),
        IconSlideAction(
          caption: 'Reminder',
          color: Colors.lightBlue,
          icon: Icons.alarm,
          foregroundColor: Colors.white,
          onTap: () => pickDateTime(context),
        ),
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
