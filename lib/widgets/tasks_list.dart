import 'package:flutter/material.dart';
import 'package:publist/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:publist/models/task_data.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];

            return TaskTile(
              taskTitle: task.name,
              taskStatus: task.taskStatus,
              triggerSuccess: () {
                taskData.triggerSuccess(task);
              },
              triggerFail: () {
                taskData.triggerFail(task);
              },
              triggerDelete: () {
                taskData.deleteTask(task);
              },
              triggerActivate: () {
                taskData.triggerActivate(task);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
