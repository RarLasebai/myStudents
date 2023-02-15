import 'package:my_students/features/day/domain/entities/student.dart';

abstract class StudentStates {}

//reusable states
class InitStudentState implements StudentStates {}

class LoadingStudentState implements StudentStates {}

class ErrorStudentState implements StudentStates {
  final String message;
  ErrorStudentState(this.message);
}

//add

class StudentAddedState implements StudentStates {}

//get
class StudentsLoadedState implements StudentStates {
  final List<Student> students;
  StudentsLoadedState(this.students);
}

class GetFilterListState implements StudentStates {
  final List<Student> students;
  GetFilterListState(this.students);
}

//update
class StudentUpdateState implements StudentStates {}

class StudentUpdatedState implements StudentStates {}

class UpdateGradeLoadingState implements StudentStates {}

class UpdateGradeLoadedState implements StudentStates {}

class UpdateStarsLoadingState implements StudentStates {}

class UpdateStarsLoadedState implements StudentStates {}

//delete
class ResetGradesLoadingState implements StudentStates {}

class ResetGradesLoadedState implements StudentStates {}

class DeleteStudentsLoadingState implements StudentStates {}

class DeleteStudentsLoadedState implements StudentStates {}

class DeleteOneStudentLoadedState implements StudentStates {}

class DeleteOneStudentLoadingState implements StudentStates {}
