import 'package:flutter/foundation.dart';
import 'package:publist/models/group.dart';
import 'package:publist/firebase services/data_service.dart';

class GroupData extends ChangeNotifier {
  Group currentGroup;

  Future getGroupDataByGroupID(String groupID) async {
    var dummyQueryOutput = await DataService()
        .getCollectionByIdQuery(documentID: groupID, collection: 'groups');

    currentGroup = Group(
        groupLists: dummyQueryOutput['groupLists'],
        groupID: groupID,
        groupCreatorID: dummyQueryOutput['groupCreatorID'],
        groupMembers: dummyQueryOutput['groupMembers'],
        name: dummyQueryOutput['groupName'],
        description: dummyQueryOutput['groupDescription'],
        createdAt: dummyQueryOutput['createdAt']);

    notifyListeners();
  }

  List get groupLists {
    return currentGroup.groupLists;
  }

  String get groupName {
    return currentGroup.name;
  }

  int get memberCount {
    return currentGroup.groupMembers.length;
  }

  int get listCount {
    return currentGroup.groupLists.length;
  }
}
