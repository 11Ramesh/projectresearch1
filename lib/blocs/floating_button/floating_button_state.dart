part of 'floating_button_bloc.dart';

@immutable
abstract class FloatingButtonState {}

class FloatingButtonInitial extends FloatingButtonState {}

class addCorrectAnswerState extends FloatingButtonState {
  List correctAnswers;

  addCorrectAnswerState({required this.correctAnswers});
}

class TopicButtonState extends FloatingButtonState {
  int countNumber;

  TopicButtonState({required this.countNumber});
}
