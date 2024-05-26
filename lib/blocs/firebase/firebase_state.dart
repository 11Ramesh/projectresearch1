part of 'firebase_bloc.dart';

@immutable
abstract class FirebaseState {}

class FirebaseInitial extends FirebaseState {}

class addQuestionState extends FirebaseState {
  List question;
  List<dynamic> questionId;
  int questionCount;
  List structureQuestionsList;
  List<dynamic> structureQuestionId;
  int structureQuestionCount;
  addQuestionState(
      {required this.question,
      required this.questionId,
      required this.questionCount,
      required this.structureQuestionsList,
      required this.structureQuestionId,
      required this.structureQuestionCount});
}

class solutionState extends FirebaseState {
  List wrongAnswerReferIndexes;
  List wrongStructureAnswerReferIndexes;
  List correctAnswer;
   Map<String, dynamic> yourGivenAnswer;
        Map<String, dynamic> userInputAnswerIndexList ;

  solutionState(
      {required this.wrongAnswerReferIndexes,
      required this.wrongStructureAnswerReferIndexes,required this.yourGivenAnswer, required this.userInputAnswerIndexList,required this.correctAnswer});
}

class solutionPart2State extends FirebaseState {
  List solutionList;
  List finalSolutionList;
  List finalSolutionToDo;

  solutionPart2State(
      {required this.finalSolutionList,
      required this.solutionList,
      required this.finalSolutionToDo});
}

class answerSheetState extends FirebaseState {
  Map yourGivenAnswer;
  List questionsListforAnswerSheet;

  answerSheetState(
      {required this.yourGivenAnswer,
      required this.questionsListforAnswerSheet});
}
