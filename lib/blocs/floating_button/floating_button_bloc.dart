import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'floating_button_event.dart';
part 'floating_button_state.dart';

class FloatingButtonBloc
    extends Bloc<FloatingButtonEvent, FloatingButtonState> {
  FloatingButtonBloc() : super(FloatingButtonInitial()) {
    on<FloatingButtonEvent>((event, emit) {
      List correctAnswers = [];

      if (event is addCorrectAnswerEvent) {
        dynamic selectAnswer = event.selectAnswer;
        dynamic correctAnswer = event.correctAnswer;
        dynamic questionIndex = event.questionIndex;
        correctAnswers = event.correctAnswers;

        if (correctAnswers.contains(questionIndex)) {
          print("have");
          if (selectAnswer == correctAnswer) {
            print("Do not repeate");
          } else {
            correctAnswers.remove(questionIndex);
            print("remove");
          }
        } else if (selectAnswer == correctAnswer) {
          correctAnswers.add(questionIndex);
          print("Add");
        }

        emit(addCorrectAnswerState(correctAnswers: correctAnswers));
      } else if (event is TopicButtonEvent) {
        int countNumber = event.countNumber;

        countNumber = countNumber + 1;
        //ispage = !ispage;
        print(countNumber);
        emit(TopicButtonState(countNumber: countNumber));
      } 
    });
  }
}
