import 'package:flutter/material.dart';
import 'package:publist/models/group_task_data.dart';
import 'package:publist/widgets/task_related_widgets/task_tile.dart';
import 'package:provider/provider.dart';

class GroupMainTaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupTaskData>(
      builder: (context, groupTaskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final groupTask = groupTaskData.groupTasks[index];

            return TaskTile(
              taskStatus: groupTask.taskStatus,
              taskTitle: groupTask.name,
              triggerActivate: () {
                groupTaskData.triggerActivate(groupTask);
              },
              triggerFail: () {
                groupTaskData.triggerFail(groupTask);
              },
              triggerDelete: () {
                groupTaskData.deleteTask(groupTask);
              },
              triggerSuccess: () {
                groupTaskData.triggerSuccess(groupTask);
              },
              setDateTime: (dateTime) {
                groupTaskData.setDateTime(groupTask, dateTime);
              },
            );
          },
          itemCount: groupTaskData.taskCount,
        );
      },
    );
  }
}
