import 'package:breakpoint/mp3player_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MP3PlayerApp());

class MP3PlayerApp extends StatelessWidget {
  const MP3PlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MP3 Player',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.black,
          secondary: Colors.red,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.red),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.red,
        ),
        dividerColor: Colors.black12,
      ),
      home: const MP3PlayerScreen(),
    );
  }
}
