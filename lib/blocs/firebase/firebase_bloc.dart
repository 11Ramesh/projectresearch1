import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
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
      CollectionReference mcq1 = FirebaseFirestore.instance.collection("mcq1");

      //collection for solution
      CollectionReference solution =
          FirebaseFirestore.instance.collection("solution");

      //collection for question structure
      CollectionReference structure =
          FirebaseFirestore.instance.collection("structure1");

      List questionsList = [];
      List structureQuestionsList = [];
      Map<String, dynamic> data;

      List wrongAnswerReferIndexes = [];
      List<dynamic> questionId = [];
      List structureQuestionId = [];
      int questionCount = 0;
      int structureQuestionCount = 0;
      List solutionList = [];
      List kotasweladapola = [];
      List samantharasheni = [];
      List baaga = [];
      List prethishatha = [];
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

        // for (var wrongAnswerId in wrongAnswer) {
        //   var mc = await mcq1.doc(wrongAnswerId).get();
        //   var studentData = mc.data() as Map<String, dynamic>;
        //   var referIndex = studentData['referindex'];

        //   // Add referIndex to the list
        //   wrongAnswerReferIndexes.add(referIndex);
        // }

        print(wrongAnswerReferIndexes);

        // send the wrongAnswerReferIndexes to font end
        emit(solutionState(
            wrongAnswerReferIndexes: wrongAnswerReferIndexes,
            wrongStructureAnswerReferIndexes: wrongStructureAnswer));

        //
      } else if (event is solutionPart2Event) {
        wrongAnswerReferIndexes = event.wrongAnswerReferIndexes;

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
            if (element['topic'] == 'කොටස් වෙළඳපොළ') {
              kotasweladapola.add(element);
            } else if (element['topic'] == 'සමාන්තර ශ්‍රේණි') {
              samantharasheni.add(element);
            } else if (element['topic'] == 'භාග') {
              baaga.add(element);
            } else if (element['topic'] == 'ප්‍රතිශත') {
              prethishatha.add(element);
            }
          });
          if (kotasweladapola.length != 0) {
            finalSolutionList.add(kotasweladapola);
          }
          if (samantharasheni.length != 0) {
            finalSolutionList.add(samantharasheni);
          }
          if (baaga.length != 0) {
            finalSolutionList.add(baaga);
          }
          if (prethishatha.length != 0) {
            finalSolutionList.add(prethishatha);
          }

          if (kotasweladapola.length > 2) {
            finalSolutionToDo.add(kotasweladapola);
          }
          if (samantharasheni.length > 2) {
            finalSolutionToDo.add(samantharasheni);
          }
          if (baaga.length > 2) {
            finalSolutionToDo.add(baaga);
          }
          if (prethishatha.length > 2) {
            finalSolutionToDo.add(prethishatha);
          }

          // data send to solutionPart2State from the this state
          emit(solutionPart2State(
              finalSolutionList: finalSolutionList,
              solutionList: solutionList,
              finalSolutionToDo: finalSolutionToDo));
        });
      }
    });
  }
}




//${mcqNo.toString()}