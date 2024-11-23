import 'package:flutter/material.dart';
import 'quiz_setup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customizable Quiz App',
      theme: ThemeData.dark(), // Enable dark mode
      home: QuizSetupScreen(),
    );
  }
}
