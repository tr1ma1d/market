import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.purple,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.black)
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontSize: 24.0),  // TextStyle для заголовков
    bodyLarge: TextStyle(fontSize: 14.0),  // TextStyle для основного текста
    bodyMedium: TextStyle(fontSize: 12.0, color: Colors.black),  // TextStyle для второстепенного текста
  ),
  iconTheme: const IconThemeData(
    color: Colors.purple,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(Colors.purple),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),

    ),
  ),
  
);
