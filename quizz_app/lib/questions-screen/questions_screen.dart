import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/questions_data/questions_data.dart';
import 'package:quizz_app/questions-screen/answer_button.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(this.addSelectedAnswer, {super.key});

  final void Function(String answer) addSelectedAnswer;

  @override
  State createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var questionIndex = 0;

  void changeAnswer(String answer) {
    widget.addSelectedAnswer(answer);

    setState(() {
      questionIndex++;
    });
  }

  @override
  Widget build(context) {
    final actualQuestion = questions[questionIndex];

    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              actualQuestion.question,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.purple[50],
              ),
            ),
            const SizedBox(height: 20),
            /*Se usa el operador de propagacion porque children espera una List<Widget>,
               sino devolveria una List<Iterable<Widget>>*/
            ...actualQuestion.answersShuffled.map(
              (answer) => Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: AnswerButton(
                  answer,
                  () {
                    changeAnswer(answer);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
