import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.grey,
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.black)),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromRGBO(86, 64, 218, 1),
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
        fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.w500),
    titleMedium: TextStyle(
        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(
        fontSize: 16,
        color: Color.fromRGBO(86, 64, 218, 1),
        fontWeight: FontWeight.bold), // TextStyle для заголовков
    bodyLarge: TextStyle(
        fontSize: 18.0, color: Colors.black), // TextStyle для основного текста
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black),
    bodySmall: TextStyle(fontSize: 12.0, color: Colors.black),

    // TextStyle для подзаголовков
    // TextStyle для второстепенного текста
  ),
  iconTheme: const IconThemeData(
    color: Color.fromRGBO(86, 64, 218, 1),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          WidgetStateProperty.all<Color>(const Color.fromRGBO(86, 64, 218, 1)),
      foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
    ),
  ),
  cardTheme: const CardTheme(
    color: Colors.white,
    shadowColor: Colors.black, // Assign Colors.black to a variable
    elevation: 0.0, 
  ),
  indicatorColor: Colors.grey,
  // containerTheme: const CardTheme(
  //   color: Colors.white,
  // ),
);
