import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'firebase_event.dart';
part 'firebase_state.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  FirebaseBloc() : super(FirebaseInitial()) {
    on<FirebaseEvent>((event, emit) async {
      //collection for question
      CollectionReference mcq1 = FirebaseFirestore.instance.collection("mcq1");

      //collection for solution
      CollectionReference solution =
          FirebaseFirestore.instance.collection("solution");

      List questionsList = [];
      Map<String, dynamic> data;
      Map<String, dynamic> StudentWantStudyData;
      List wrongAnswerReferIndexes = [];
      List<dynamic> questionId = [];
      int questionCount = 0;
      List solutionList = [];
      List area = [];
      List volume = [];
      List finalSolutionList = [];

      if (event is addQuestionEvent) {
        await mcq1.get().then((QuerySnapshot snapshot) {
          snapshot.docs.forEach((DocumentSnapshot document) {
            //get all question id
            questionId.add(document.id);
            //print(questionId);
            //get all data from the back end
            data = document.data() as Map<String, dynamic>;
            questionsList.add(data);
          });
          //get list contains item count
          questionCount = questionsList.length;
          //print(questionsList);
          emit(addQuestionState(
              question: questionsList,
              questionId: questionId,
              questionCount: questionCount));
        });

        //
      } else if (event is solutionEvent) {
        List<String> allQuestion = event.allQuestion.toList().cast<String>();
        List<String> correctAnswer =
            event.correctAnswer.toList().cast<String>();
        List<String> wrongAnswer = allQuestion;

        //get the wrong  answer from using allQuestion, correctAnswer lists
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
        // send the wrongAnswerReferIndexes to font end
        emit(solutionState(wrongAnswerReferIndexes: wrongAnswerReferIndexes));

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
              area.add(element);
            } else if (element['topic'] == 'volume') {
              volume.add(element);
            }
          });
          if(area.length != 0){
              finalSolutionList.add(area);
          }
          if(volume.length != 0){
              finalSolutionList.add(volume);
          }
          
          

          // data send to solutionPart2State from the this state
          emit(solutionPart2State(
              finalSolutionList: finalSolutionList,
              solutionList: solutionList));
        });
      }
    });
  }
}
