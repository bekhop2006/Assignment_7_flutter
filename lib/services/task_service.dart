import '../models/task.dart';

enum TaskFilter { all, active, completed }

class TaskService {
  static bool isValidTitle(String title) {
    return title.trim().length >= 3;
  }

  static List<Task> addTask(List<Task> tasks, String title) {
    final normalizedTitle = title.trim();

    if (!isValidTitle(normalizedTitle)) {
      throw ArgumentError('Task title must contain at least 3 characters.');
    }

    return [...tasks, Task(title: normalizedTitle)];
  }

  static List<Task> toggleTask(List<Task> tasks, int index) {
    if (index < 0 || index >= tasks.length) {
      throw RangeError.index(index, tasks);
    }

    return [
      for (var i = 0; i < tasks.length; i++)
        if (i == index)
          tasks[i].copyWith(isCompleted: !tasks[i].isCompleted)
        else
          tasks[i],
    ];
  }

  static List<Task> filterTasks(List<Task> tasks, TaskFilter filter) {
    return switch (filter) {
      TaskFilter.all => tasks,
      TaskFilter.active => tasks.where((task) => !task.isCompleted).toList(),
      TaskFilter.completed => tasks.where((task) => task.isCompleted).toList(),
    };
  }

  static int completedCount(List<Task> tasks) {
    return tasks.where((task) => task.isCompleted).length;
  }
}
