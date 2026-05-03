import 'package:flutter/material.dart';

import '../services/task_service.dart';
import '../state/app_state.dart';
import '../widgets/task_tile.dart';

class TaskManagerScreen extends StatefulWidget {
  const TaskManagerScreen({super.key, required this.state});

  final AppState state;

  @override
  State<TaskManagerScreen> createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTask() {
    final error = widget.state.addTask(_controller.text);
    setState(() {
      _errorText = error;
    });
    if (error == null) {
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final visibleTasks = state.visibleTasks;

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
                      'Completed: ${state.completedCount} of ${state.totalCount}',
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
              selected: {state.filter},
              onSelectionChanged: (selection) =>
                  state.setFilter(selection.first),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: visibleTasks.length,
                itemBuilder: (context, index) {
                  final task = visibleTasks[index];
                  final originalIndex = state.tasks.indexOf(task);

                  return TaskTile(
                    key: Key('taskTile$originalIndex'),
                    task: task,
                    onChanged: () => state.toggleTask(originalIndex),
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
