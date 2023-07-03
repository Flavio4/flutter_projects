import 'package:flutter/material.dart';
import 'package:quizz_app/questions-screen/questions_screen.dart';
import 'package:quizz_app/questions_data/questions_data.dart';
import 'package:quizz_app/questions_results/questions_results.dart';
import 'home-app/home.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State createState() => _QuizState();
}

///////////////////////////// STATE ///////////////////////////////////////////
class _QuizState extends State<Quiz> {
  Widget? activeScreen;

  final List<String> selectedAnswers = [];

  @override
  void initState() {
    activeScreen = Home(changeScreen);
    super.initState();
  }

  void changeScreen() {
    setState(() {
      activeScreen = QuestionsScreen(addSelectedAnswer);
    });
    selectedAnswers.clear();
  }

  void addSelectedAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = QuestionsResult(changeScreen, selectedAnswers);
      });
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
