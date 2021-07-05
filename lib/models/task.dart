import 'package:publist/enums.dart';

class Task {
  final String name;
  TaskStatus taskStatus;

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
