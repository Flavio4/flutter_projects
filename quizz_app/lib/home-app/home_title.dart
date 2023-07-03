import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "My First Quiz App!",
      style: GoogleFonts.poppins(
        color: Colors.purple[50],
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
