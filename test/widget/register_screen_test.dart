import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ninety/screens/register_screen.dart';

void main() {
  testWidgets('Register screen widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: RegisterScreen(),
    ));

    // Verify that our counter starts at 0.
    expect(find.text('Register \nwith Us'), findsOneWidget);
    expect(find.byType(TextFormField), findsWidgets);
    expect(find.widgetWithText(TextButton, "Sign in"), findsOneWidget);
    expect(
        find.widgetWithText(ElevatedButton, "Create Account"), findsOneWidget);
  });
}
