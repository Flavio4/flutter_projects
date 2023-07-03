import 'package:flutter/material.dart';

class HelloWorld extends StatelessWidget {
  const HelloWorld(this.textMessage, {super.key});

  final String textMessage;

  @override
  Widget build(context) {
    return Text(
      textMessage,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
