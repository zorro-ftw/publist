import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:publist/models/group_data.dart';
import 'package:publist/widgets/group_related_widgets/group_member_tile.dart';

class GroupMemberList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupData>(builder: (context, groupData, child) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final groupMembers = groupData.currentGroup.groupMembers;

          return GroupMemberTile();
        },
        itemCount: groupData.memberCount,
      );
    });
  }
}
