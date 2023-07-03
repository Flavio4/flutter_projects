import 'package:flutter/material.dart';
import 'package:quizz_app/home-app/home_image.dart';
import 'package:quizz_app/home-app/home_title.dart';

class Home extends StatelessWidget {
  const Home(this.changeScreen, {super.key});

  final void Function() changeScreen;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const HomeImage(),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: const HomeTitle(),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: FilledButton.icon(
              onPressed: changeScreen,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: Colors.black, width: 0.5),
                ),
              ),
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text("Start Quiz"),
            ),
          ),
        ],
      ),
    );
  }
}
