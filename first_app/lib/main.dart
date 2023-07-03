import 'package:first_app/hello_world_text.dart';
import 'package:flutter/material.dart';
import 'package:first_app/dice_app.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const HelloWorld("Mi primera App"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: const DiceApp(Colors.orange, Colors.red),
      ),
    ),
  );
}
