import 'package:flutter/material.dart';

const double PADDING_TOP = 80;
const double PADDING_LEFT = 30;
const double PADDING_RIGHT = 30;

const BACKEND_URL = "https://ninetycamera.azurewebsites.net/api/";

const String AUTH_TOKEN = "AUTH_TOKEN";

Color mainPurple = Color(0xfff6C63FF);

final ButtonStyle raisedButtonStyleRed = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: Color(0xfffF50057),
  minimumSize: const Size(double.infinity, 50),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle raisedButtonStylePurple = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: Color(0xfff6C63FF),
  minimumSize: const Size(double.infinity, 50),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

Map<int, Color> color = {
  50: const Color.fromRGBO(108, 99, 255, .1),
  100: const Color.fromRGBO(108, 99, 255, .2),
  200: const Color.fromRGBO(108, 99, 255, .3),
  300: const Color.fromRGBO(108, 99, 255, .4),
  400: const Color.fromRGBO(108, 99, 255, .5),
  500: const Color.fromRGBO(108, 99, 255, .6),
  600: const Color.fromRGBO(108, 99, 255, .7),
  700: const Color.fromRGBO(108, 99, 255, .8),
  800: const Color.fromRGBO(108, 99, 255, .9),
  900: const Color.fromRGBO(108, 99, 255, 1),
};

MaterialColor mainColor = MaterialColor(0x6C63FF, color);
