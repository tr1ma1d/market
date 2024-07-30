import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.black,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 24.0),  // TextStyle для заголовков
    bodyLarge: TextStyle(fontSize: 16.0),  // TextStyle для основного текста
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.grey),  // TextStyle для второстепенного текста
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    ),
  ),
);
