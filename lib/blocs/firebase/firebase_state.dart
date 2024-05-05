part of 'firebase_bloc.dart';

@immutable
abstract class FirebaseState {}

class FirebaseInitial extends FirebaseState {}

class addQuestionState extends FirebaseState {
  List question;
  List<dynamic> questionId;
  int questionCount;
  addQuestionState(
      {required this.question,
      required this.questionId,
      required this.questionCount});
}

class solutionState extends FirebaseState {
  List wrongAnswerReferIndexes;

  solutionState({required this.wrongAnswerReferIndexes});
}

class solutionPart2State extends FirebaseState {
  List solutionList;
  List finalSolutionList;

  solutionPart2State(
      {required this.finalSolutionList, required this.solutionList});
}
