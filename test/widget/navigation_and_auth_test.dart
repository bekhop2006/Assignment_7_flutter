import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_testing_app/main.dart';

void main() {
  testWidgets('bottom nav shows three destinations', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byKey(const Key('bottomNav')), findsOneWidget);
    expect(find.text('Tasks'), findsOneWidget);
    expect(find.text('Stats'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('user can navigate to Stats tab and see progress', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Stats'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('progressLabel')), findsOneWidget);
    expect(find.text('50% completed'), findsOneWidget);
  });

  testWidgets('user can log in from Settings tab', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('loginTitle')), findsOneWidget);

    await tester.enterText(find.byKey(const Key('usernameInput')), 'beknur');
    await tester.enterText(find.byKey(const Key('passwordInput')), 'secret123');
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('welcomeText')), findsOneWidget);
    expect(find.text('Welcome, beknur!'), findsOneWidget);
    expect(find.byKey(const Key('logoutButton')), findsOneWidget);
  });

  testWidgets('login shows error for invalid password', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('usernameInput')), 'beknur');
    await tester.enterText(find.byKey(const Key('passwordInput')), '123');
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump();

    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    expect(find.byKey(const Key('welcomeText')), findsNothing);
  });
}
