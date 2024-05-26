part of 'floating_button_bloc.dart';

@immutable
abstract class FloatingButtonEvent {}

class addCorrectAnswerEvent extends FloatingButtonEvent {
  dynamic selectAnswer;
  dynamic questionIndex;
  dynamic correctAnswer;
  List correctAnswers;
  int index;

  List indexList = [];
  Map<String, dynamic> userSelectIndexList;

  addCorrectAnswerEvent(
      this.selectAnswer,
      this.questionIndex,
      this.correctAnswer,
      this.correctAnswers,
      this.index,
      this.userSelectIndexList,
      this.indexList);
}

class TopicButtonEvent extends FloatingButtonEvent {
  int countNumber;

  TopicButtonEvent(this.countNumber);
}
