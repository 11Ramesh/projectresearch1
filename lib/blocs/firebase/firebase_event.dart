part of 'firebase_bloc.dart';

@immutable
abstract class FirebaseEvent {}

class addQuestionEvent extends FirebaseEvent {}

class solutionEvent extends FirebaseEvent {
  List allQuestion;
  List correctAnswer;
  List allStructureQuestionId;
  List correctStructureAnswers;
  
  Map<String, dynamic> yourGivenAnswer;
  Map<String, dynamic> userInputAnswerIndexList;
  solutionEvent(
      this.allQuestion,
      this.correctAnswer,
      this.allStructureQuestionId,
      this.correctStructureAnswers,
      this.yourGivenAnswer,
      this.userInputAnswerIndexList);
}

class solutionPart2Event extends FirebaseEvent {
  List wrongAnswerReferIndexes;
  solutionPart2Event(this.wrongAnswerReferIndexes);
}

class answerSheetEvent extends FirebaseEvent {
  Map yourGivenAnswer;
  answerSheetEvent(this.yourGivenAnswer);
}
