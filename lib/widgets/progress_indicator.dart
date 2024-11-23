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
    return LinearProgressIndicator(
      value: (currentQuestion + 1) / totalQuestions,
    );
  }
}
