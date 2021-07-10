import 'package:flutter/material.dart';
import 'package:publist/models/user_group_data.dart';
import 'package:publist/screens/group_related_screens/group_main_screen.dart';
import 'package:publist/widgets/group_related_widgets/group_tile.dart';
import 'package:provider/provider.dart';

/// Main Screen'de Groups sekmesine geçildiğinde (Group Main Screen açıldığında)
/// kullanıcının üyesi olduğu grupları çeken listeleme Widget'ı.

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
                // await Provider.of<GroupData>(context, listen: false)
                //     .getGroupDataByGroupID(group.groupID);
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
