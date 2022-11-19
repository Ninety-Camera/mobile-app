import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ninety/models/cctv_system.dart';
import 'package:ninety/models/user.dart';
import 'package:ninety/providers/system.dart';
import 'package:ninety/screens/dashboard_screen.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Home page widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => System()),
        ],
        child: DashboardScreen(
            appUser: AppUser(
          lastName: "Last name",
          email: "testemail@gmail.com",
          id: "1234",
          role: "OWNER",
          firstName: "Test First name",
          cctvSystem: CCTV_System(
            cameraCount: 0,
            id: "123",
            status: "RUNNING",
          ),
        )),
      ),
    ));

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('STOP'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, "View previous intrusions"),
        findsOneWidget);

    await tester.tap(find.text("View previous intrusions"));
    await tester.pump();
  });
}
