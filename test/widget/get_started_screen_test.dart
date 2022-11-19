import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ninety/screens/get_started_sceen.dart';

void main() {
  testWidgets('Get Started screen widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: GetStartedScreen(),
    ));

    // Verify that our counter starts at 0.
    expect(find.text('Get Started'), findsOneWidget);
    expect(find.text('Get'), findsNothing);
    expect(find.widgetWithText(ElevatedButton, "Login"), findsOneWidget);
    expect(
        find.widgetWithText(ElevatedButton, "Create Account"), findsOneWidget);

    await tester.tap(find.text("Login"));
    await tester.pump();

    await tester.tap(find.text("Create Account"));
    await tester.pump();
  });
}
