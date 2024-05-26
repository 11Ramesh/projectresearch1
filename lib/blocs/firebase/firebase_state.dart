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
 
  solutionState(
      {required this.wrongAnswerReferIndexes,
      required this.wrongStructureAnswerReferIndexes,
      required this.yourGivenAnswer,
      
      required this.correctAnswer});
}

class solutionPart2State extends FirebaseState {
  List solutionList;
  List finalSolutionList;
  List finalSolutionToDo;
  List wrongAnswerReferIndexes;
  List allQuestion;
  List correctAnswer;
  List allStructureQuestionId;
   List correctStructureAnswers ;

  Map<String, dynamic> yourGivenAnswer;
  Map<String, dynamic> userInputAnswerIndexList;
  solutionPart2State(
      {required this.finalSolutionList,
      required this.solutionList,
      required this.finalSolutionToDo,
      required this.wrongAnswerReferIndexes,
      required this.allQuestion,
      required this.yourGivenAnswer,
      required this.userInputAnswerIndexList,
      required this.correctAnswer,
      required this.allStructureQuestionId,
      required this.correctStructureAnswers,

      });
}

class answerSheetState extends FirebaseState {
  Map<String, dynamic> yourGivenAnswer;
  Map<String, dynamic> userInputAnswerIndexList;
  List questionsListforAnswerSheet;
  
  List StructureQuestionsListforAnswerSheet;
  List wrongAnswerReferIndexes ;
  List<dynamic> allQuestionId ;
  List<dynamic> correctAnswers ;
  List<dynamic> allStructureQuestionId ;
  List<dynamic> correctStructureAnswers ;

  answerSheetState(
      {required this.yourGivenAnswer,
      required this.userInputAnswerIndexList,
      required this.questionsListforAnswerSheet,
      required this.StructureQuestionsListforAnswerSheet,
      required this.wrongAnswerReferIndexes,
      required this.allQuestionId,
      required this.correctAnswers,
      required this.allStructureQuestionId,
      required this.correctStructureAnswers,
      });
}
