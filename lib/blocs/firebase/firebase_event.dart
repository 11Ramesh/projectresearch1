part of 'firebase_bloc.dart';

@immutable
abstract class FirebaseEvent {}

class addQuestionEvent extends FirebaseEvent {}

class solutionEvent extends FirebaseEvent {
  List allQuestion;
  List correctAnswer;
  solutionEvent(this.allQuestion, this.correctAnswer);
}

class solutionPart2Event extends FirebaseEvent {
  List wrongAnswerReferIndexes;
  solutionPart2Event(this.wrongAnswerReferIndexes);
}


