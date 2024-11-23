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
      appBar: AppBar(title: Text('Quiz Setup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Number of Questions:'),
            DropdownButton<int>(
              value: numberOfQuestions,
              items: [5, 10, 15].map((value) {
                return DropdownMenuItem(value: value, child: Text('$value'));
              }).toList(),
              onChanged: (value) => setState(() => numberOfQuestions = value!),
            ),
            SizedBox(height: 10),
            Text('Select Difficulty:'),
            DropdownButton<String>(
              value: difficulty,
              items: ['easy', 'medium', 'hard'].map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) => setState(() => difficulty = value!),
            ),
            SizedBox(height: 10),
            Text('Select Question Type:'),
            DropdownButton<String>(
              value: questionType,
              items: ['multiple', 'boolean'].map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) => setState(() => questionType = value!),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
