// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test3/main.dart';

void main() {
  testWidgets('Dashboard UI smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FigmaToCodeApp());

    // Verify that the title is displayed
    expect(find.text('Your Steps Progress'), findsOneWidget);

    // Verify that the step count is displayed
    expect(find.text('8,312 steps done'), findsOneWidget);

    // Verify that the period buttons are present
    expect(find.text('Daily'), findsOneWidget);
    expect(find.text('Monthly'), findsOneWidget);
    expect(find.text('Yearly'), findsOneWidget);

    // Verify that the bottom navigation items are present
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Challenges'), findsOneWidget);
    expect(find.text('Equipment'), findsOneWidget);
    expect(find.text('Shop'), findsOneWidget);
  });
}
