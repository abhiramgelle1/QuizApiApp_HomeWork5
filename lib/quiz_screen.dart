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
  String feedback = '';

  void handleAnswer(String selectedAnswer) {
    final correctAnswer = widget.questions[currentQuestion]['correct_answer'];
    setState(() {
      if (selectedAnswer == correctAnswer) {
        feedback = 'Correct!';
        score++;
      } else {
        feedback = 'Incorrect! The correct answer was: $correctAnswer';
      }

      Future.delayed(Duration(seconds: 2), () {
        if (currentQuestion < widget.questions.length - 1) {
          setState(() {
            currentQuestion++;
            feedback = '';
          });
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProgressIndicatorWidget(
              currentQuestion: currentQuestion,
              totalQuestions: widget.questions.length,
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  question['question'],
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (feedback.isNotEmpty)
              Text(
                feedback,
                style: TextStyle(
                    fontSize: 16,
                    color: feedback == 'Correct!' ? Colors.green : Colors.red),
                textAlign: TextAlign.center,
              ),
            SizedBox(height: 20),
            ...options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: ElevatedButton(
                  onPressed: () => handleAnswer(option),
                  child: Text(option, textAlign: TextAlign.center),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
