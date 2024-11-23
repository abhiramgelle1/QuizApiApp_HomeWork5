import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  ResultScreen({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Summary')),
      body: Center(
        child: Column(
          children: [
            Text('Your Score: $score / $total'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Retake Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
