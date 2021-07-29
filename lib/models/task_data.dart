import 'package:flutter/foundation.dart';
import 'package:publist/models/task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'Buy milk'),
    Task(name: 'Buy eggs'),
    Task(name: 'Buy bread'),
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }

  void triggerSuccess(Task task) {
    task.successTask();
    notifyListeners();
  }

  void triggerFail(Task task) {
    task.failTask();
    notifyListeners();
  }

  void triggerActivate(Task task) {
    task.activateTask();
    notifyListeners();
  }
  void setDateTime(Task task,DateTime dateTime) {
    task.setDateTime(dateTime);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
