import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publist/models/user_invite_data.dart';
import 'package:publist/widgets/group_related_widgets/invite_tile.dart';
import 'package:provider/provider.dart';

class UserInvitesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserInviteData>(
      builder: (context, userInviteData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final invite = userInviteData.invites[index];

            return InviteTile(
              groupTitle: invite.inviteForName,
              senderName: invite.senderName,
              onTapCallback: () {
                // showDialog(context: context, builder: );
              },
            );
          },
          itemCount: userInviteData.invites.length,
        );
      },
    );
  }
}