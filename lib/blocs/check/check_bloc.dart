import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'check_event.dart';
part 'check_state.dart';

class CheckBloc extends Bloc<CheckEvent, CheckState> {
  CheckBloc() : super(CheckInitial()) {
    on<CheckEvent>((event, emit) {
      if (event is DataGetSolutionTopicPageEvent) {
        int index = event.index;
        int countNumber = event.countNumber;
        List finalSolutionList = event.finalSolutionList;

        emit(DataGetSolutionTopicPageState(
            countNumber: countNumber,
            index: index,
            finalSolutionList: finalSolutionList));
      }
    });
  }
}
