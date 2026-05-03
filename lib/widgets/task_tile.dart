import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, required this.onChanged});

  final Task task;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CheckboxListTile(
        value: task.isCompleted,
        onChanged: (_) => onChanged(),
        title: Text(task.title),
        subtitle: Text(task.isCompleted ? 'Done' : 'Active'),
      ),
    );
  }
}
