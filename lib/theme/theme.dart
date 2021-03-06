import 'package:flutter/material.dart';

final lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: Colors.teal,
  secondaryHeaderColor: Colors.black,
  scaffoldBackgroundColor: const Color.fromARGB(255, 21, 61, 190),
  canvasColor: const Color.fromARGB(255, 108, 163, 226),
  errorColor: const Color.fromARGB(255, 231, 19, 19),
);

final darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(255, 3, 2, 51),
  secondaryHeaderColor: Colors.white,
  scaffoldBackgroundColor: const Color(0xFF170635),
  canvasColor: const Color.fromARGB(255, 18, 24, 105),
  errorColor: const Color.fromARGB(255, 199, 3, 3),
);
