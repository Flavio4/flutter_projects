import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData
              .map(
                (data) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          color: data['correctAnswer'] == data['userAnswer']
                              ? const Color.fromARGB(255, 144, 202, 249)
                              : const Color.fromARGB(255, 241, 73, 129),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                            ((data['questionIndex'] as int) + 1).toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['question'] as String,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              data['userAnswer'] as String,
                              style: TextStyle(
                                color: Colors.purple[300],
                              ),
                            ),
                            Text(
                              data['correctAnswer'] as String,
                              style: TextStyle(
                                color: Colors.blue[300],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
