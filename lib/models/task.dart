import 'package:publist/enums.dart';

class Task {
  final String name;
  TaskStatus taskStatus;
  // bool isDone;
  // bool isSuccess;
  // bool isFail;

  Task({this.name, this.taskStatus = TaskStatus.active});

  void successTask() {
    taskStatus = TaskStatus.success;
  }

  void failTask() {
    taskStatus = TaskStatus.fail;
  }

  void activateTask() {
    taskStatus = TaskStatus.active;
  }
}
