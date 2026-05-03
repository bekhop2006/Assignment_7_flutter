import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_testing_app/main.dart';

void main() {
  testWidgets('main screen shows task manager content', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Task Testing App'), findsOneWidget);
    expect(find.text('Read testing chapter'), findsOneWidget);
    expect(find.text('Write widget test'), findsOneWidget);
    expect(find.byKey(const Key('addTaskButton')), findsOneWidget);
  });

  testWidgets('user can add a new task from text field', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(
      find.byKey(const Key('taskInput')),
      'Prepare report',
    );
    await tester.tap(find.byKey(const Key('addTaskButton')));
    await tester.pump();

    expect(find.text('Prepare report'), findsOneWidget);
    expect(find.text('Completed: 1 of 3'), findsOneWidget);
  });

  testWidgets('short task title shows validation message', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byKey(const Key('taskInput')), 'Hi');
    await tester.tap(find.byKey(const Key('addTaskButton')));
    await tester.pump();

    expect(find.text('Enter at least 3 characters'), findsOneWidget);
    expect(find.text('Completed: 1 of 2'), findsOneWidget);
  });

  testWidgets('tapping checkbox updates completed counter', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Completed: 1 of 2'), findsOneWidget);

    await tester.tap(find.byKey(const Key('taskTile0')));
    await tester.pump();

    expect(find.text('Completed: 2 of 2'), findsOneWidget);
  });
}
