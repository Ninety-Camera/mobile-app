import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ninety/screens/home_screen.dart';

void main() {
  testWidgets('Home page widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: HomeScreen(),
    ));

    // Verify that our counter starts at 0.
    expect(find.text('Ninety Camera'), findsOneWidget);
    expect(find.text('Ninety'), findsNothing);
    expect(find.widgetWithText(ElevatedButton, "Get started"), findsOneWidget);

    await tester.tap(find.text("Get started"));
    await tester.pump();
  });
}
