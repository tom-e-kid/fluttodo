import 'package:flutter/material.dart';

import '../../models/task.dart';

typedef TaskCompletionCallback = void Function(bool completion);
typedef TaskSelectionCallback = void Function();

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key? key,
    required this.task,
    required this.onComplete,
    this.onSelect,
  }) : super(key: key);

  final Task task;
  final TaskCompletionCallback onComplete;
  final TaskSelectionCallback? onSelect;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: ListTile(
        leading: Checkbox(
          shape: const CircleBorder(),
          onChanged: (flag) {
            if (flag != null) {
              onComplete(flag);
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
        onTap: onSelect,
      ),
    );
  }
}
