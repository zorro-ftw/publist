import 'package:flutter/foundation.dart';
import 'package:publist/firebase_services/auth_service.dart';
import 'package:publist/models/group.dart';
import 'package:publist/firebase_services/data_service.dart';
import 'package:publist/models/group_member.dart';

class GroupData extends ChangeNotifier {
  Group currentGroup;
  List<GroupMember> currentGroupMembers = [];
  bool isCurrentUserAdmin;

  var dummyQueryOutput;

  Future getGroupDataByGroupID(String groupID) async {
    dummyQueryOutput = await DataService()
        .getCollectionByIdQuery(documentID: groupID, collection: 'groups');

    await getCurrentGroupMembers();

    print(currentGroupMembers);

    currentGroup = Group(
        groupLists: dummyQueryOutput['groupLists'],
        groupID: groupID,
        groupCreatorID: dummyQueryOutput['groupCreatorID'],
        groupMembers: currentGroupMembers,
        groupAdmins: dummyQueryOutput['groupAdmins'],
        name: dummyQueryOutput['groupName'],
        description: dummyQueryOutput['groupDescription'],
        createdAt: dummyQueryOutput['createdAt']);

    notifyListeners();
  }

  Future getCurrentGroupMembers() async {
    currentGroupMembers = [];
    List currentGroupMemberIDs = dummyQueryOutput['groupMembers'].keys.toList();
    List currentGroupMemberNames =
        dummyQueryOutput['groupMembers'].values.toList();
    List currentGroupAdmins = dummyQueryOutput['groupAdmins'];

    print(dummyQueryOutput['groupAdmins']);
    print(AuthService().currentUserId);
    if (currentGroupAdmins.contains(AuthService().currentUserId)) {
      isCurrentUserAdmin = true;
      print("TRUE OLDU");
    } else {
      isCurrentUserAdmin = false;
      print("FALSE OLDU");
    }

    for (int i = 0; i < currentGroupMemberIDs.length; i++) {
      currentGroupMembers.add(
        GroupMember(
          memberID: currentGroupMemberIDs[i],
          memberName: currentGroupMemberNames[i],
          isAdmin: currentGroupAdmins.contains(
            currentGroupMemberIDs[i],
          ),
        ),
      );
    }
  }

  List get groupLists {
    return currentGroup.groupLists;
  }

  String getGroupName() {
    String groupName;
    groupName = currentGroup.name;
    return groupName;
  }

  String getGroupID() {
    String groupName;
    groupName = currentGroup.groupID;
    return groupName;
  }

  /// Sadece grup adı ve description için kullanılmalı
  Future updateGroupInfo(
      {String groupID, String updatedField, String newValue}) async {
    await DataService().updateDataByID(
        collectionPath: 'groups',
        docID: groupID,
        field: updatedField,
        value: newValue);
    if (updatedField == 'groupName') {
      currentGroup = Group(
          groupLists: currentGroup.groupLists,
          groupID: currentGroup.groupID,
          groupCreatorID: currentGroup.groupCreatorID,
          groupMembers: currentGroupMembers,
          groupAdmins: currentGroup.groupAdmins,
          name: newValue,
          description: currentGroup.description,
          createdAt: currentGroup.createdAt);
    } else if (updatedField == 'groupDescription') {
      currentGroup = Group(
          groupLists: currentGroup.groupLists,
          groupID: currentGroup.groupID,
          groupCreatorID: currentGroup.groupCreatorID,
          groupMembers: currentGroupMembers,
          groupAdmins: currentGroup.groupAdmins,
          name: currentGroup.name,
          description: newValue,
          createdAt: currentGroup.createdAt);
    }
    notifyListeners();
  }

  int get memberCount {
    return currentGroup.groupMembers.length;
  }

  int get listCount {
    return currentGroup.groupLists.length;
  }

  // Future<Map<String, List>> get memberInfo async{
  //   Map memberInfo;
  //   for(String member in currentGroup.groupMembers){
  //     Map memberInfo={member:[UserInfo('member').displayName]
  //
  //     }
  //   }
  //   return memberInfo;
  //   //TODO - Üyelerin profil fotoğrafları ve isimleri alınacak
  // }
}
