import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ninety/screens/forgot_password_screen.dart';

void main() {
  testWidgets('Reset Password screen widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: ForgotPasswordScreen(),
    ));

    // Verify that our counter starts at 0.
    expect(find.text('Reset your Password'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);
    expect(find.widgetWithText(TextButton, "Sign in"), findsNothing);
    expect(find.widgetWithText(ElevatedButton, "Send Email"), findsOneWidget);
  });
}
