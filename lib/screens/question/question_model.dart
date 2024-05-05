class Question {
  final String questions;
  final List<String> options;
  final int correctAnswerIndex;

  const Question({
    required this.correctAnswerIndex,
    required this.questions,
    required this.options,
  });
}
