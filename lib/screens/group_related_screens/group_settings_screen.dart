import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:publist/constants.dart';
import 'package:publist/models/group_data.dart';
import 'package:provider/provider.dart';

class GroupSettingsScreen extends StatelessWidget {
  final String currentGroupID;
  final String currentGroupName;

  GroupSettingsScreen({this.currentGroupName, this.currentGroupID});

  @override
  Widget build(BuildContext context) {
    String newGroupName;

    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 110),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(
            height: 8,
          ),
          kDivider,
          SizedBox(
            height: 8,
          ),
          Container(
            decoration: BoxDecoration(
                color: Provider.of<GroupData>(context).isCurrentUserAdmin
                    ? kMainThemeColor
                    : kDisabledButtonFillColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            constraints: BoxConstraints(maxWidth: 250.0, minHeight: 40.0),
            margin: EdgeInsets.all(8),
            child: TextButton(
              onPressed: Provider.of<GroupData>(context).isCurrentUserAdmin

                  ///currentUser admin değilse onpressed boş bir fonksiyon olmalı
                  ? () {
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                elevation: 10,
                                title: Text('Enter new group name'),
                                content: TextField(
                                  keyboardType: TextInputType.name,
                                  autofocus: true,
                                  textAlign: TextAlign.center,
                                  onChanged: (newText) {
                                    newGroupName = newText;
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      //TODO - Yeni grup ismi için firebase tarafındaki işleri yapacak fonksiyon buraya gelmeli
                                      Provider.of<GroupData>(context,
                                              listen: false)
                                          .updateGroupInfo(
                                              groupID: currentGroupID,
                                              updatedField: 'groupName',
                                              newValue: newGroupName);
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: Text(
                                      'Update',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          barrierDismissible: true);
                    }
                  : () {}

              /// Yukarıda bahsedilen boş fonksiyon
              ,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Change Group Name',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
