import 'package:flutter/foundation.dart';
import 'package:publist/firebase_services/data_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:publist/models/task.dart';
import 'package:publist/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskData extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Task> _tasks = [];
  List userTaskRawData = [];
  List newTaskRawData = [];

  List<Task> get tasks {
    return _tasks;
  }

  int get taskCount {
    return _tasks.length;
  }

  Future getUserTasks() async {
    userTaskRawData = await DataService().getStringQuery(
        queryString: _auth.currentUser.uid,
        collection: 'tasks',
        field: 'userID');
    print(userTaskRawData);

    if (_tasks.isEmpty) {
      for (int i = 0; i < userTaskRawData.length; i++) {
        TaskStatus taskStatus;
        switch (userTaskRawData[i].data()['taskStatus']) {
          case 'Active':
            {
              taskStatus = TaskStatus.active;
              break;
            }
          case 'Success':
            {
              taskStatus = TaskStatus.success;
              break;
            }
          case 'Fail':
            {
              taskStatus = TaskStatus.fail;
              break;
            }
        }

        Task currentTask = Task(
            taskID: userTaskRawData[i].id,
            createdAt: userTaskRawData[i].data()['createdAt'],
            name: userTaskRawData[i].data()['taskName'],
            groupID: userTaskRawData[i].data()['groupID'],
            taskStatus: taskStatus,
            attachmentUrl: userTaskRawData[i].data()['attachmentUrl']);
        print(!_tasks.contains(currentTask));

        _tasks.add(currentTask);
      }
    }

    notifyListeners();
  }

  void addTask(String newTaskTitle) async {
    final task = Task(
        name: newTaskTitle,
        groupID: '',
        createdAt: Timestamp.now(),
        userID: _auth.currentUser.uid,
        attachmentUrl: '');

    await firestore.collection('tasks').add({
      'attachmentUrl': task.attachmentUrl,
      'createdAt': task.createdAt,
      'groupID': task.groupID,
      'reminderDate': null,
      'taskName': task.name,
      'taskStatus': 'Active',
      'userID': task.userID
    });

    newTaskRawData = await DataService().getStringQuery(
        queryString: _auth.currentUser.uid,
        collection: 'tasks',
        field: 'userID');
    Task currentTask = Task(
        taskID: newTaskRawData[newTaskRawData.length - 1].id,
        createdAt:
            newTaskRawData[newTaskRawData.length - 1].data()['createdAt'],
        name: newTaskRawData[newTaskRawData.length - 1].data()['taskName'],
        groupID: newTaskRawData[newTaskRawData.length - 1].data()['groupID'],
        taskStatus: TaskStatus.active,
        attachmentUrl:
            newTaskRawData[newTaskRawData.length - 1].data()['attachmentUrl']);
    _tasks.add(currentTask);
    notifyListeners();
  }

  void triggerSuccess(Task task) async {
    await DataService().updateDataByID(
        collectionPath: 'tasks',
        docID: task.taskID,
        field: 'taskStatus',
        value: 'Success');
    task.successTask();
    notifyListeners();
  }

  void triggerFail(Task task) async {
    await DataService().updateDataByID(
        collectionPath: 'tasks',
        docID: task.taskID,
        field: 'taskStatus',
        value: 'Fail');
    task.failTask();
    notifyListeners();
  }

  void triggerActivate(Task task) async {
    await DataService().updateDataByID(
        collectionPath: 'tasks',
        docID: task.taskID,
        field: 'taskStatus',
        value: 'Active');
    task.activateTask();
    notifyListeners();
  }

  void setDateTime(Task task, DateTime dateTime) async {
    await DataService().updateDataByID(
        collectionPath: 'tasks',
        docID: task.taskID,
        field: 'reminderDate',
        value: dateTime);
    task.setDateTime(dateTime);

    notifyListeners();
  }

  void deleteTask(Task task) async {
    await firestore.collection('tasks').doc(task.taskID).delete();
    _tasks.remove(task);
    notifyListeners();
  }
}
