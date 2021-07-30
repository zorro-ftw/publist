import 'package:flutter/foundation.dart';
import 'package:publist/firebase_services/data_service.dart';
import 'package:publist/models/task.dart';
import 'package:publist/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupTaskData extends ChangeNotifier {
  List<Task> _groupTasks = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getGroupTasks({String currentGroupID}) async {
    await for (var snapshot in firestore
        .collection('tasks')
        .where('groupID', isEqualTo: currentGroupID)
        .orderBy('createdAt', descending: false)
        .snapshots()) {
      updateGroupTasks(snapshot);
      notifyListeners();
    }
  }

  int get taskCount {
    return _groupTasks.length;
  }

  List<Task> get groupTasks {
    return _groupTasks;
  }

  Future addTask({String newTaskTitle, String groupID}) async {
    final task = Task(
        name: newTaskTitle,
        groupID: groupID,
        createdAt: Timestamp.now(),
        userID: '',
        attachmentUrl: '');
    _groupTasks.add(task);

    await firestore.collection('tasks').add({
      'attachmentUrl': task.attachmentUrl,
      'createdAt': task.createdAt,
      'groupID': task.groupID,
      'reminderDate': null,
      'taskName': task.name,
      'taskStatus': 'Active',
      'userID': null
    });
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
    _groupTasks.remove(task);
    notifyListeners();
  }

  void updateGroupTasks(QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Task> onlineTaskList = [];
    if (snapshot.size != 0) {
      for (int i = 0; i < snapshot.docs.length; i++) {
        TaskStatus taskStatus;
        switch (snapshot.docs[i].data()['taskStatus']) {
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
            taskID: snapshot.docs[i].id,
            createdAt: snapshot.docs[i].data()['createdAt'],
            name: snapshot.docs[i].data()['taskName'],
            groupID: snapshot.docs[i].data()['groupID'],
            taskStatus: taskStatus,
            attachmentUrl: snapshot.docs[i].data()['attachmentUrl']);

        onlineTaskList.add(currentTask);

        if (_groupTasks.length == 0) {
          _groupTasks.add(currentTask);
        } else if (_groupTasks.length <= snapshot.size) {
          bool isNew = true;
          for (int j = 0; j < _groupTasks.length; j++) {
            if (_groupTasks[j].taskID == currentTask.taskID) {
              isNew = false;
              _groupTasks[j] = currentTask;
            }
          }
          if (isNew) {
            _groupTasks.add(currentTask);
          }
        }
      }

      if (_groupTasks.length > snapshot.size) {
        for (int k = 0; k < _groupTasks.length; k++) {
          if (!onlineTaskList.contains(_groupTasks[k])) {
            _groupTasks.removeAt(k);
          }
        }
      }
    } else {
      _groupTasks.clear();
    }
  }
}
