import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:publist/models/group.dart';
import 'dart:collection';

class GroupData extends ChangeNotifier {
  List<String> _groupMembers = ['Ahmet', 'Mehmet', 'Ayşe', 'Fatma'];

  UnmodifiableListView<String> get groupMembers {
    return UnmodifiableListView(_groupMembers);
  }

  int get memberCount {
    return _groupMembers.length;
  }

  List<String> _groupLists = ['Liste1', 'Liste2', 'Liste3'];

  UnmodifiableListView<String> get groupLists {
    return UnmodifiableListView(_groupLists);
  }

  int get listCount {
    return _groupLists.length;
  }
}
