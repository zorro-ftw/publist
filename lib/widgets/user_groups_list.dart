import 'package:flutter/material.dart';
import 'package:publist/models/user_group_data.dart';
import 'package:publist/screens/group_related_screens/group_main_screen.dart';
import 'package:publist/widgets/group_tile.dart';
import 'package:provider/provider.dart';

class GroupsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserGroupData>(
      builder: (context, userGroupData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final group = userGroupData.groups[index];

            return GroupTile(
              groupTitle: group.name,
              groupDescription: group.description,
              onTapCallback: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return GroupMainScreen(groupID: group.groupID);
                }));
              },
            );
          },
          itemCount: userGroupData.groupCount,
        );
      },
    );
  }
}
