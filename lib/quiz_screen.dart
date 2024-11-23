import 'package:flutter/material.dart';
import 'widgets/countdown_timer.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final List<dynamic> questions;

  QuizScreen({required this.questions});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;

  void handleAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) score++;
      if (currentQuestion < widget.questions.length - 1) {
        currentQuestion++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ResultScreen(score: score, total: widget.questions.length)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestion];
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: Column(
        children: [
          CountdownTimer(
            onTimeout: () => handleAnswer(false),
            duration: 15,
          ),
          Text(question['question']),
          // Options rendering logic...
        ],
      ),
    );
  }
}
