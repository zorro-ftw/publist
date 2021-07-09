import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:publist/models/group.dart';
import 'dart:collection';
import 'package:publist/firebase services/data_service.dart';

class UserGroupData extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  List userGroupRawData;
  List newGroupRawData;

  List<Group> _groups = [];
  List<String> groupMembers = [];

  Future getUserGroups() async {
    if (_groups.isEmpty) {
      userGroupRawData = await DataService().getArrayQuery(
          queryString: _auth.currentUser.uid,
          collection: 'groups',
          field: 'groupMembers');

      for (int i = 0; i < userGroupRawData.length; i++) {
        _groups.add(
          Group(
              name: userGroupRawData[i].data()['groupName'],
              description: userGroupRawData[i].data()['groupDescription'],
              groupID: userGroupRawData[i].id),
        );
      }
      notifyListeners();
    }
  }

  int get groupCount {
    return _groups.length;
  }

  UnmodifiableListView<Group> get groups {
    return UnmodifiableListView(_groups);
  }

  Future addGroup(String newGroupTitle, String newGroupDescription) async {
    final group = Group(
      name: newGroupTitle,
      description: newGroupDescription,
      createdAt: Timestamp.now(),
    );
    await DataService().createNewGroup(group, _auth.currentUser.uid);
    newGroupRawData = await DataService().getArrayQuery(
        queryString: _auth.currentUser.uid,
        collection: 'groups',
        field: 'groupMembers');

    // print(newGroupRawData[0].data()['groupName']);
    // print(newGroupRawData[1].data()['groupName']);
    // print(newGroupRawData[2].data()['groupName']);
    // print(newGroupRawData[3].data()['groupName']);
    // print(newGroupRawData[4].data()['groupName']);

    _groups.add(
      Group(
        name: newGroupRawData[newGroupRawData.length - 1].data()['groupName'],
        description: newGroupRawData[newGroupRawData.length - 1]
            .data()['groupDescription'],
        groupID: newGroupRawData[newGroupRawData.length - 1].id,
        createdAt:
            newGroupRawData[newGroupRawData.length - 1].data()['createdAt'],
      ),
    );

    notifyListeners();
  }

  void deleteGroup(Group group) {
    //TODO - Firebase'den de çıkarması lazım, henüz eklenmedi.
    _groups.remove(group);
    notifyListeners();
  }
}
