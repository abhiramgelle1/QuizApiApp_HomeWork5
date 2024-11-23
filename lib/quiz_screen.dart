import 'package:flutter/material.dart';
import 'result_screen.dart';
import 'widgets/countdown_timer.dart';
import 'widgets/progress_indicator.dart';

class QuizScreen extends StatefulWidget {
  final List<dynamic> questions;

  QuizScreen({required this.questions});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;

  void handleAnswer(String selectedAnswer) {
    final correctAnswer = widget.questions[currentQuestion]['correct_answer'];
    setState(() {
      if (selectedAnswer == correctAnswer) score++;
      if (currentQuestion < widget.questions.length - 1) {
        currentQuestion++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              score: score,
              total: widget.questions.length,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestion];
    final options = List<String>.from(question['incorrect_answers']);
    options.add(question['correct_answer']);
    options.shuffle();

    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProgressIndicatorWidget(
              currentQuestion: currentQuestion,
              totalQuestions: widget.questions.length,
            ),
            SizedBox(height: 20),
            Text(
              question['question'],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            CountdownTimer(
              duration: 15,
              onTimeout: () => handleAnswer(''),
            ),
            SizedBox(height: 20),
            ...options.map((option) {
              return ElevatedButton(
                onPressed: () => handleAnswer(option),
                child: Text(option),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
