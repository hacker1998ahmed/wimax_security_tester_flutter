import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.deepPurple[700],
    ),
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.black87,
    ),
  );
}