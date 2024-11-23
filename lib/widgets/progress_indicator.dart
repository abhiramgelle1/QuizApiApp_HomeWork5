import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;

  ProgressIndicatorWidget({
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Question ${currentQuestion + 1} of $totalQuestions',
          style: TextStyle(fontSize: 18),
        ),
        LinearProgressIndicator(
          value: (currentQuestion + 1) / totalQuestions,
          backgroundColor: Colors.grey,
          color: Colors.blue,
        ),
      ],
    );
  }
}
