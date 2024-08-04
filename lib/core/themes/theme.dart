import 'package:flutter/material.dart';
//TODO: make more color and adding images
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
    titleLarge: TextStyle(fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.w500),  // TextStyle для заголовков
    bodyLarge: TextStyle(fontSize: 18.0, color: Colors.black),  // TextStyle для основного текста
    bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black),
    bodySmall: TextStyle(fontSize: 11.0, color: Colors.black),  // TextStyle для второстепенного текста
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
  cardTheme: const CardTheme(
    color: Colors.white,
  ),
  indicatorColor: Colors.grey,
  

);
