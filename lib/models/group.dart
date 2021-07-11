import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:publist/models/group_member.dart';

class Group {
  final String groupID;
  final String name;
  final String description;
  final Timestamp createdAt;
  final List<GroupMember> groupMembers;

  final List groupAdmins;

  final List groupLists;
  final String groupCreatorID;

  Group({
    this.groupID,
    this.name,
    this.description,
    this.createdAt,
    this.groupMembers,
    this.groupLists,
    this.groupCreatorID,
    this.groupAdmins,
  });
}
