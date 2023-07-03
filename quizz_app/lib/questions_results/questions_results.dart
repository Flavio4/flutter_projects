import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/questions_results/questions_summary.dart';

import '../questions_data/questions_data.dart';

class QuestionsResult extends StatelessWidget {
  const QuestionsResult(this.restartQuiz, this.selectedAnswers, {super.key});

  final void Function() restartQuiz;
  final List<String> selectedAnswers;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summaryData = [];
    for (var i = 0; i < selectedAnswers.length; i++) {
      summaryData.add({
        "questionIndex": i,
        "question": questions[i].question,
        "correctAnswer": questions[i].answer[0],
        "userAnswer": selectedAnswers[i],
      });
    }
    return summaryData;
  }

  @override
  Widget build(context) {
    final List<Map<String, Object>> summaryData = getSummaryData();
    final int totalQuestions = questions.length;
    final int correctAnswers = summaryData
        .where((data) => data['correctAnswer'] == data['userAnswer'])
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your answered $correctAnswers out of $totalQuestions questions correctly",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple[50],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(
              summaryData,
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton.icon(
              onPressed: restartQuiz,
              style: TextButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.purple[50],
              ),
              icon: const Icon(
                Icons.refresh,
              ),
              label: const Text(
                "Reiniciar Quiz",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
