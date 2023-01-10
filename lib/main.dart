import 'package:activity5/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Activity 5',
    theme: ThemeData(
      primaryColor: Colors.teal,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.black54),
    ),
    home: const HomeScreen()

  ));
}
