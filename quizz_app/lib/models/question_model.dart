class QuestionModel {
  const QuestionModel(this.question, this.answer);

  final String question;
  final List<String> answer;

  List<String> get answersShuffled {
    final answersShuffled = List.of(answer);
    answersShuffled.shuffle();
    return answersShuffled;
  }
}
