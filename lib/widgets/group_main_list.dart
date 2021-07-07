import 'package:flutter/material.dart';
import 'package:publist/models/group_data.dart';
import 'package:publist/widgets/group_list_tile.dart';
import 'package:provider/provider.dart';

class GroupsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupData>(
      builder: (context, groupData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final groupList = groupData.groupLists[index];

            return GroupListTile(
                listTitle: groupList,
                onTapCallback: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return GroupMainScreen(groupName: group.name);
                });
          },
          itemCount: groupData.listCount,
        );
      },
    );
  }
}
