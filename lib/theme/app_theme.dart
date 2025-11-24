import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Color.fromRGBO(64, 189, 76, 1),
    scaffoldBackgroundColor: const Color(0xFFDAE2DB),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFE7EEE9),
      labelStyle: TextStyle(color: Colors.black87),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF97A39B)),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  );
}
