import 'package:flutter/material.dart';
import 'quiz_screen.dart';
import 'services/api_service.dart';

class QuizSetupScreen extends StatefulWidget {
  @override
  _QuizSetupScreenState createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  int numberOfQuestions = 5;
  String category = '9'; // Default: General Knowledge
  String difficulty = 'easy';
  String questionType = 'multiple';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setup Quiz')),
      body: Column(
        children: [
          DropdownButton<int>(
            value: numberOfQuestions,
            items: [5, 10, 15].map((value) {
              return DropdownMenuItem(
                  value: value, child: Text('$value Questions'));
            }).toList(),
            onChanged: (value) => setState(() => numberOfQuestions = value!),
          ),
          // Add dropdowns for category, difficulty, and type...
          ElevatedButton(
            onPressed: () async {
              var questions = await APIService.fetchQuestions(
                  numberOfQuestions, category, difficulty, questionType);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuizScreen(questions: questions)),
              );
            },
            child: Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}
