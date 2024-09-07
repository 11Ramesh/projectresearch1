import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'firebase_event.dart';
part 'firebase_state.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  FirebaseBloc() : super(FirebaseInitial()) {
    on<FirebaseEvent>((event, emit) async {
      SharedPreferences mcq = await SharedPreferences.getInstance();
      int? mcqNo = mcq.getInt('mcq');
      //collection for question mcq
      CollectionReference mcq1 =
          FirebaseFirestore.instance.collection("mcq${mcqNo.toString()}");

      //collection for solution
      CollectionReference solution =
          FirebaseFirestore.instance.collection("solution");

      //collection for question structure
      CollectionReference structure =
          FirebaseFirestore.instance.collection("structure${mcqNo.toString()}");

      List questionsList = [];
      List structureQuestionsList = [];
      Map<String, dynamic> data;

      List wrongAnswerReferIndexes = [];
      List<dynamic> questionId = [];
      List structureQuestionId = [];
      int questionCount = 0;
      int structureQuestionCount = 0;
      List solutionList = [];
      List kulaka = [];
      List samikarana = [];
      List vijiyabaaga = [];
      List prethishatha = [];
      List shreni = [];
      List vargapalaya = [];
      List parimaawa = [];
      List trikona = [];
      List samakonitrikona = [];
      List trikonamithiya = [];

      List finalSolutionList = [];
      List finalSolutionToDo = [];

      if (event is addQuestionEvent) {
        QuerySnapshot querySnapshot = await mcq1.get();

        for (var mcq in querySnapshot.docs) {
          //get all question id
          questionId.add(mcq.id);
          //print(questionId);
          //get all data from the back end
          data = mcq.data() as Map<String, dynamic>;
          questionsList.add(data);
        }
        //get list contains item count
        questionCount = questionsList.length;

        QuerySnapshot querySnapshot1 = await structure.get();

        for (var structures in querySnapshot1.docs) {
          //get all  structure question id
          structureQuestionId.add(structures.id);

          //get all data from the back end
          data = structures.data() as Map<String, dynamic>;
          structureQuestionsList.add(data);
        }
        //get list contains item count
        structureQuestionCount = structureQuestionsList.length;

        emit(addQuestionState(
            question: questionsList,
            questionId: questionId,
            questionCount: questionCount,
            structureQuestionsList: structureQuestionsList,
            structureQuestionId: structureQuestionId,
            structureQuestionCount: structureQuestionCount));
      } else if (event is solutionEvent) {
        Map<String, dynamic> yourGivenAnswer = event.yourGivenAnswer;

        //for mcq question
        List<String> allQuestion = event.allQuestion.toList().cast<String>();
        List<String> correctAnswer =
            event.correctAnswer.toList().cast<String>();
        List<String> wrongAnswer = allQuestion;

        //for structure question

        List<String> allStructureQuestionId =
            event.allStructureQuestionId.toList().cast<String>();
        List<String> correctStructureAnswers =
            event.correctStructureAnswers.toList().cast<String>();
        List<String> wrongStructureAnswer = allStructureQuestionId;

        //get the wrong  answer from using all McQ Question, correctAnswer lists
        correctAnswer.forEach((answer) {
          if (answer != null) {
            wrongAnswer.remove(answer);
          }
        });

        for (var wrongAnswerId in wrongAnswer) {
          var mc = await mcq1.doc(wrongAnswerId).get();
          var studentData = mc.data() as Map<String, dynamic>;
          var referIndex = studentData['referindex'];

          // Add referIndex to the list
          wrongAnswerReferIndexes.add(referIndex);
        }

        for (var correctStructureAnswer in correctStructureAnswers) {
          if (correctStructureAnswer != null) {
            wrongStructureAnswer.remove(correctStructureAnswer);
          }
        }

        for (var wrongStructureId in wrongStructureAnswer) {
          var mc = await structure.doc(wrongStructureId).get();
          var studentData = mc.data() as Map<String, dynamic>;
          var referIndex = studentData['referindex'];

          // Add referIndex to the list
          wrongAnswerReferIndexes.add(referIndex);
        }

        // send the wrongAnswerReferIndexes to font end
        emit(solutionState(
            wrongAnswerReferIndexes: wrongAnswerReferIndexes,
            wrongStructureAnswerReferIndexes: wrongStructureAnswer,
            yourGivenAnswer: yourGivenAnswer,
            correctAnswer: correctAnswer));

        //
      } else if (event is answerSheetEvent) {
        Map<String, dynamic> yourGivenAnswer = event.yourGivenAnswer;
        Map<String, dynamic> userInputAnswerIndexList =
            event.userInputAnswerIndexList;
        List questionsListforAnswerSheet = [];
        List structureQuestionsListforAnswerSheet = [];

        List wrongAnswerReferIndexes = event.wrongAnswerReferIndexes;
        List<dynamic> allQuestionId = event.allQuestionId;
        List<dynamic> correctAnswers = event.correctAnswers;
        List<dynamic> allStructureQuestionId = event.allStructureQuestionId;
        List<dynamic> correctStructureAnswers = event.correctStructureAnswers;
        QuerySnapshot querySnapshot = await mcq1.get();
        QuerySnapshot querySnapshot1 = await structure.get();

        for (var mcq in querySnapshot.docs) {
          data = mcq.data() as Map<String, dynamic>;
          questionsListforAnswerSheet.add(data);
        }
        for (var structre in querySnapshot1.docs) {
          data = structre.data() as Map<String, dynamic>;
          structureQuestionsListforAnswerSheet.add(data);
        }

        emit(answerSheetState(
            yourGivenAnswer: yourGivenAnswer,
            questionsListforAnswerSheet: questionsListforAnswerSheet,
            userInputAnswerIndexList: userInputAnswerIndexList,
            StructureQuestionsListforAnswerSheet:
                structureQuestionsListforAnswerSheet,
            wrongAnswerReferIndexes: wrongAnswerReferIndexes,
            allQuestionId: allQuestionId,
            correctAnswers: correctAnswers,
            allStructureQuestionId: allStructureQuestionId,
            correctStructureAnswers: correctStructureAnswers));
      }

      ///
      else if (event is solutionPart2Event) {
        wrongAnswerReferIndexes = event.wrongAnswerReferIndexes;
        List allQuestion = event.allQuestion;
        List correctAnswer = event.correctAnswer;
        List allStructureQuestionId = event.allStructureQuestionId;
        List correctStructureAnswers = event.correctStructureAnswers;

        Map<String, dynamic> yourGivenAnswer = event.yourGivenAnswer;
        Map<String, dynamic> userInputAnswerIndexList =
            event.userInputAnswerIndexList;

        await solution.get().then((QuerySnapshot snapshot) {
          //get solution collection id
          snapshot.docs.forEach((DocumentSnapshot document) {
            data = document.data() as Map<String, dynamic>;

            wrongAnswerReferIndexes.forEach((solutionReferIndexes) {
              //get solution colection reflex idies and check it equal
              //or not with wrong answer list items
              if (data['referindex'] == solutionReferIndexes) {
                solutionList.add(data);
              }
            });
          });

          // data send to solutionPart2State from the this state
          //emit(solutionPart2State(solutionList: solutionList));

          // data devide to multiple topics
          solutionList.forEach((element) {
            if (element['topic'] == 'කුළක') {
              kulaka.add(element);
            } else if (element['topic'] == 'සමීකරණ') {
              samikarana.add(element);
            } else if (element['topic'] == 'වීජීය භාග') {
              vijiyabaaga.add(element);
            } else if (element['topic'] == 'ප්‍රතිශත') {
              prethishatha.add(element);
            } else if (element['topic'] ==
                'සමාන්තර ශ්‍රේඪි හා ගුණෝත්තර ශ්‍රේඪි') {
              shreni.add(element);
            } else if (element['topic'] == 'ඝණ වස්තු වල පෘශ්ථ වර්ගඵලය') {
              vargapalaya.add(element);
            } else if (element['topic'] == 'ඝණ වස්තු වල පරිමාව') {
              parimaawa.add(element);
            } else if (element['topic'] == 'ත්‍රිකෝණ') {
              trikona.add(element);
            } else if (element['topic'] == 'සමකෝණී ත්‍රිකෝණ') {
              samakonitrikona.add(element);
            } else if (element['topic'] == 'ත්‍රිකෝණමිතිය') {
              trikonamithiya.add(element);
            }
          });
          if (kulaka.length != 0) {
            finalSolutionList.add(kulaka);
          }
          if (samikarana.length != 0) {
            finalSolutionList.add(samikarana);
          }
          if (vijiyabaaga.length != 0) {
            finalSolutionList.add(vijiyabaaga);
          }
          if (prethishatha.length != 0) {
            finalSolutionList.add(prethishatha);
          }
          if (shreni.length != 0) {
            finalSolutionList.add(shreni);
          }
          if (vargapalaya.length != 0) {
            finalSolutionList.add(vargapalaya);
          }
          if (trikona.length != 0) {
            finalSolutionList.add(trikona);
          }
          if (samakonitrikona.length != 0) {
            finalSolutionList.add(samakonitrikona);
          }
          if (trikonamithiya.length != 0) {
            finalSolutionList.add(trikonamithiya);
          }
          if (parimaawa.length != 0) {
            finalSolutionList.add(parimaawa);
          }

          if (kulaka.length > 2) {
            finalSolutionToDo.add(kulaka);
          }
          if (samikarana.length > 2) {
            finalSolutionToDo.add(samikarana);
          }
          if (vijiyabaaga.length > 2) {
            finalSolutionToDo.add(vijiyabaaga);
          }
          if (prethishatha.length > 2) {
            finalSolutionToDo.add(prethishatha);
          }
          if (shreni.length > 2) {
            finalSolutionToDo.add(shreni);
          }
          if (vargapalaya.length > 2) {
            finalSolutionToDo.add(vargapalaya);
          }
          if (parimaawa.length > 2) {
            finalSolutionToDo.add(parimaawa);
          }
          if (trikona.length > 2) {
            finalSolutionToDo.add(trikona);
          }
          if (samakonitrikona.length > 2) {
            finalSolutionToDo.add(samakonitrikona);
          }
          if (trikonamithiya.length > 2) {
            finalSolutionToDo.add(trikonamithiya);
          }
          print(yourGivenAnswer);
          // data send to solutionPart2State from the this state
          emit(solutionPart2State(
              finalSolutionList: finalSolutionList,
              solutionList: solutionList,
              finalSolutionToDo: finalSolutionToDo,
              wrongAnswerReferIndexes: wrongAnswerReferIndexes,
              allQuestion: allQuestion,
              yourGivenAnswer: yourGivenAnswer,
              userInputAnswerIndexList: userInputAnswerIndexList,
              correctAnswer: correctAnswer,
              allStructureQuestionId: allStructureQuestionId,
              correctStructureAnswers: correctStructureAnswers));
        });
      }
    });
  }
}




//${mcqNo.toString()}