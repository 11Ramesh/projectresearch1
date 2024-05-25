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

  solutionState({required this.wrongAnswerReferIndexes,required this.wrongStructureAnswerReferIndexes});
}

class solutionPart2State extends FirebaseState {
  List solutionList;
  List finalSolutionList;
  List finalSolutionToDo;

  solutionPart2State(
      {required this.finalSolutionList, required this.solutionList,required this.finalSolutionToDo});
}
