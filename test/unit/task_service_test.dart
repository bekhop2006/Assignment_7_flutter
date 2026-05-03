import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_app/models/task.dart';
import 'package:flutter_testing_app/services/task_service.dart';

void main() {
  group('TaskService', () {
    test('validates task titles by trimming whitespace', () {
      expect(TaskService.isValidTitle('Study'), isTrue);
      expect(TaskService.isValidTitle('  Go  '), isFalse);
      expect(TaskService.isValidTitle('   '), isFalse);
    });

    test('adds a normalized active task', () {
      final tasks = TaskService.addTask(const [], '  Practice testing  ');

      expect(tasks, hasLength(1));
      expect(tasks.first.title, 'Practice testing');
      expect(tasks.first.isCompleted, isFalse);
    });

    test('filters active and completed tasks correctly', () {
      const tasks = [
        Task(title: 'Read chapter'),
        Task(title: 'Write tests', isCompleted: true),
      ];

      final activeTasks = TaskService.filterTasks(tasks, TaskFilter.active);
      final completedTasks = TaskService.filterTasks(
        tasks,
        TaskFilter.completed,
      );

      expect(activeTasks.map((task) => task.title), ['Read chapter']);
      expect(completedTasks.map((task) => task.title), ['Write tests']);
      expect(TaskService.completedCount(tasks), 1);
    });
  });
}
