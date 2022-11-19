import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ninety/screens/login_screen.dart';

void main() {
  testWidgets('Login screen widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: LoginScreen(),
    ));

    // Verify that our counter starts at 0.
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.byType(TextFormField), findsWidgets);
    expect(find.widgetWithText(ElevatedButton, "Log in"), findsOneWidget);
    expect(find.widgetWithText(TextButton, "Forgot Password?"), findsOneWidget);
    await tester.tap(find.text("Log in"));
    await tester.pump();
  });
}
