part of 'floating_button_bloc.dart';

@immutable
abstract class FloatingButtonState {}

class FloatingButtonInitial extends FloatingButtonState {}

class addCorrectAnswerState extends FloatingButtonState {
  List correctAnswers;
  Map<String, dynamic> userGiveAnswer;

  addCorrectAnswerState({required this.correctAnswers,required this.userGiveAnswer});
}

class TopicButtonState extends FloatingButtonState {
  int countNumber;

  TopicButtonState({required this.countNumber});
}
