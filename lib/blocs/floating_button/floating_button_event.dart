part of 'floating_button_bloc.dart';

@immutable
abstract class FloatingButtonEvent {}

class addCorrectAnswerEvent extends FloatingButtonEvent {
  dynamic selectAnswer;
  dynamic questionIndex;
  dynamic correctAnswer;
  List correctAnswers;

  addCorrectAnswerEvent(this.selectAnswer, this.questionIndex,
      this.correctAnswer, this.correctAnswers);
}

class TopicButtonEvent extends FloatingButtonEvent {
  int countNumber;

  TopicButtonEvent(this.countNumber);
}


