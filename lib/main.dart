import 'package:flutter/material.dart';
import 'package:ninety/constants/constants.dart';
import 'package:ninety/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: mainColor,
        fontFamily: "Inter",
      ),
      initialRoute: HomeScreen.routeName,
      home: const HomeScreen(),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
