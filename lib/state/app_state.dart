import 'package:flutter/foundation.dart';

import '../models/task.dart';
import '../services/auth_service.dart';
import '../services/task_service.dart';

class AppState extends ChangeNotifier {
  final List<Task> _tasks = [
    const Task(title: 'Read testing chapter'),
    const Task(title: 'Write widget test', isCompleted: true),
  ];

  String? _username;
  TaskFilter _filter = TaskFilter.all;

  List<Task> get tasks => List.unmodifiable(_tasks);
  TaskFilter get filter => _filter;
  String? get username => _username;
  bool get isLoggedIn => _username != null;
  int get completedCount => TaskService.completedCount(_tasks);
  int get totalCount => _tasks.length;

  List<Task> get visibleTasks => TaskService.filterTasks(_tasks, _filter);

  String? addTask(String title) {
    if (!TaskService.isValidTitle(title)) {
      return 'Enter at least 3 characters';
    }

    final updated = TaskService.addTask(_tasks, title);
    _tasks
      ..clear()
      ..addAll(updated);
    _filter = TaskFilter.all;
    notifyListeners();
    return null;
  }

  void toggleTask(int index) {
    final updated = TaskService.toggleTask(_tasks, index);
    _tasks
      ..clear()
      ..addAll(updated);
    notifyListeners();
  }

  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  AuthResult login(String username, String password) {
    final result = AuthService.login(username, password);
    if (result.success) {
      _username = result.username;
      notifyListeners();
    }
    return result;
  }

  void logout() {
    _username = null;
    notifyListeners();
  }
}
