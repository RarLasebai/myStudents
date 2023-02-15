import 'package:my_students/features/day/data/model/student_model.dart';

abstract class SearchStates {}

class SearchInitialState implements SearchStates {}

class SearchLoadingState implements SearchStates {}

class SearchLoadedState implements SearchStates {
  final List<StudentModel>? students;
  SearchLoadedState(this.students);
}

class SearchErrorState implements SearchStates {
  String message;
  SearchErrorState(this.message);
}
