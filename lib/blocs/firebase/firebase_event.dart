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

  solutionEvent(
    this.allQuestion,
    this.correctAnswer,
    this.allStructureQuestionId,
    this.correctStructureAnswers,
    this.yourGivenAnswer,
  );
}

class solutionPart2Event extends FirebaseEvent {
  List wrongAnswerReferIndexes;
  List allQuestion;
  List correctAnswer;
  List allStructureQuestionId;
  List correctStructureAnswers;

  Map<String, dynamic> yourGivenAnswer;
  Map<String, dynamic> userInputAnswerIndexList;
  solutionPart2Event(
      this.wrongAnswerReferIndexes,
      this.allQuestion,
      this.correctAnswer,
      this.allStructureQuestionId,
      this.correctStructureAnswers,
      this.yourGivenAnswer,
      this.userInputAnswerIndexList);
}

class answerSheetEvent extends FirebaseEvent {
 
  Map<String, dynamic> yourGivenAnswer;
  Map<String, dynamic> userInputAnswerIndexList;
  List wrongAnswerReferIndexes = [];
  List<dynamic> allQuestionId = [];
  List<dynamic> correctAnswers = [];
  List<dynamic> allStructureQuestionId = [];
  List<dynamic> correctStructureAnswers = [];
  answerSheetEvent(
    
      this.yourGivenAnswer,
      this.userInputAnswerIndexList,
      this.wrongAnswerReferIndexes,
      this.allQuestionId,
      this.correctAnswers,
      this.allStructureQuestionId,
      this.correctStructureAnswers);
}
