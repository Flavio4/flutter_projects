import 'package:flutter/material.dart';
import 'dart:math';

class RollButton extends StatefulWidget {
  const RollButton({super.key});

  @override
  State<RollButton> createState() {
    return _RollButtonState();
  }
}

class _RollButtonState extends State<RollButton> {
  final randomizer = Random();
  var diceNumber = 1;

  void rollDice() {
    setState(() {
      diceNumber = randomizer.nextInt(6) + 1;
      //diceNumber = Random().nextInt(6) + 1;  >> Evitar esto porque cada vez que se cambia de estado,
      //                                          se crea un nuevo objeto Random().
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset("assets/images/dice-$diceNumber.png", width: 200),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: rollDice,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 247, 0, 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: const TextStyle(
                fontSize: 20,
              ),
            ),
            child: const Text("Tirar dados"),
          ),
        ),
      ],
    );
  }
}
