import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:publist/enums.dart';

class Task {
  final String taskID;
  final String name;
  TaskStatus taskStatus;
  DateTime dateTime;
  final Timestamp createdAt;
  final String groupID;
  final String attachmentUrl;
  final String userID;

  Task(
      {this.taskID,
      this.name,
      this.taskStatus = TaskStatus.active,
      this.createdAt,
      this.groupID,
      this.attachmentUrl,
      this.userID});

  void successTask() {
    taskStatus = TaskStatus.success;
  }

  void failTask() {
    taskStatus = TaskStatus.fail;
  }

  void activateTask() {
    taskStatus = TaskStatus.active;
  }

  void setDateTime(DateTime date) {
    dateTime = date;
  }
}
