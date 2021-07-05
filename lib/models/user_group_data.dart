import 'package:flutter/foundation.dart';
import 'package:publist/models/group.dart';
import 'dart:collection';

class UserGroupData extends ChangeNotifier {
  List<Group> _groups = [
    Group(
        name: 'AAAL--1',
        description:
            'Liseli kekoların düzenli buluşma grubu xD----------------------------------1'),
    Group(
        name: 'AAAL--2',
        description:
            'Liseli kekoların düzenli buluşma grubu xD-----------------------2'),
    Group(
        name: 'AAAL--3',
        description: 'Liseli kekoların düzenli buluşma grubu xD--3'),
    Group(
      name: 'AAAL--4',
    )
  ];

  UnmodifiableListView<Group> get groups {
    return UnmodifiableListView(_groups);
  }

  int get groupCount {
    return _groups.length;
  }

  void addGroup(String newGroupTitle, String newGroupDescription) {
    final group = Group(name: newGroupTitle, description: newGroupDescription);
    _groups.add(group);
    print('group added');
    notifyListeners();
  }

  void deleteGroup(Group group) {
    _groups.remove(group);
    notifyListeners();
  }
}
