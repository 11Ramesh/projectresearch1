part of 'check_bloc.dart';

@immutable
abstract class CheckEvent {}

class DataGetSolutionTopicPageEvent extends CheckEvent {
  int countNumber;
  int index;
  List finalSolutionList;

  DataGetSolutionTopicPageEvent(this.countNumber, this.index,this.finalSolutionList);
}
