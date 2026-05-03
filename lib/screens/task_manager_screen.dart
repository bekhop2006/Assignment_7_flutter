import 'package:flutter/material.dart';

import '../models/task.dart';
import '../services/task_service.dart';

class TaskManagerScreen extends StatefulWidget {
  const TaskManagerScreen({super.key});

  @override
  State<TaskManagerScreen> createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Task> _tasks = [
    Task(title: 'Read testing chapter'),
    Task(title: 'Write widget test', isCompleted: true),
  ];

  TaskFilter _filter = TaskFilter.all;
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTask() {
    final title = _controller.text;

    if (!TaskService.isValidTitle(title)) {
      setState(() {
        _errorText = 'Enter at least 3 characters';
      });
      return;
    }

    final updatedTasks = TaskService.addTask(_tasks, title);

    setState(() {
      _tasks
        ..clear()
        ..addAll(updatedTasks);
      _controller.clear();
      _errorText = null;
      _filter = TaskFilter.all;
    });
  }

  void _toggleTask(int index) {
    final updatedTasks = TaskService.toggleTask(_tasks, index);

    setState(() {
      _tasks
        ..clear()
        ..addAll(updatedTasks);
    });
  }

  void _setFilter(TaskFilter filter) {
    setState(() {
      _filter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final visibleTasks = TaskService.filterTasks(_tasks, _filter);
    final completedCount = TaskService.completedCount(_tasks);

    return Scaffold(
      appBar: AppBar(title: const Text('Task Testing App')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Completed: $completedCount of ${_tasks.length}',
                      key: const Key('summaryText'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      key: const Key('taskInput'),
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'New task',
                        border: const OutlineInputBorder(),
                        errorText: _errorText,
                      ),
                      onSubmitted: (_) => _addTask(),
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      key: const Key('addTaskButton'),
                      onPressed: _addTask,
                      icon: const Icon(Icons.add),
                      label: const Text('Add task'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            SegmentedButton<TaskFilter>(
              key: const Key('filterButtons'),
              segments: const [
                ButtonSegment(value: TaskFilter.all, label: Text('All')),
                ButtonSegment(value: TaskFilter.active, label: Text('Active')),
                ButtonSegment(
                  value: TaskFilter.completed,
                  label: Text('Completed'),
                ),
              ],
              selected: {_filter},
              onSelectionChanged: (selection) => _setFilter(selection.first),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: visibleTasks.length,
                itemBuilder: (context, index) {
                  final task = visibleTasks[index];
                  final originalIndex = _tasks.indexOf(task);

                  return Card(
                    child: CheckboxListTile(
                      key: Key('taskTile$originalIndex'),
                      value: task.isCompleted,
                      onChanged: (_) => _toggleTask(originalIndex),
                      title: Text(task.title),
                      subtitle: Text(task.isCompleted ? 'Done' : 'Active'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
