import 'package:flutter/material.dart';
import './pages/myhomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'چک ها',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple,
          )),
      home: const MyHomePage(),
    );
  }
}
