//import 'package:first_app/hello_world_text.dart';
import 'package:first_app/roll_button.dart';
import 'package:flutter/material.dart';

class DiceApp extends StatelessWidget {
  //Constructor
  const DiceApp(this.firstColor, this.secondColor, {super.key});
  //Se pueden crear multiples constructores, por ejemplo:
  const DiceApp.red({super.key})
      : firstColor = Colors.white,
        secondColor = Colors.red;
  //

  //Properties
  final Color firstColor;
  final Color secondColor;
  //Methods
  void rollDice() {}

  //Widget
  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [firstColor, secondColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: RollButton(),
      ),
    );
  }
}
