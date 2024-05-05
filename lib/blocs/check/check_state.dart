part of 'check_bloc.dart';

@immutable
abstract class CheckState {}

final class CheckInitial extends CheckState {}

class DataGetSolutionTopicPageState extends CheckState {
  int countNumber;
  int index;
  List finalSolutionList;

  DataGetSolutionTopicPageState(
      {required this.countNumber, required this.index, required this.finalSolutionList});
}
