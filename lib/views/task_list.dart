import 'package:flutter/material.dart';

import '../models/task.dart';

typedef TaskCompletionCallback = void Function(Task task, bool completion);

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.tasks,
    required this.onCompletion,
  }) : super(key: key);

  final List<Task> tasks;
  final TaskCompletionCallback onCompletion;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          leading: Checkbox(
            onChanged: (flag) {
              if (flag != null) {
                onCompletion(task, flag);
              }
            },
            value: task.completed,
          ),
          title: Text(
            task.text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w100,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 0.5,
        );
      },
    );
  }
}
