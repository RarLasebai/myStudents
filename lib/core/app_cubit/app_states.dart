import '../../features/day/domain/entities/student.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class BottomNavBarChangeScreenState extends AppStates {}

class InitStudentState implements AppStates {}

class LoadingStudentState implements AppStates {}

class StudentsLoadedState implements AppStates {
  final List<Student> students;
  StudentsLoadedState(this.students);
}

class ErrorStudentState implements AppStates {
  final String message;
  ErrorStudentState(this.message);
}

class AddStudentState implements AppStates {}

class StudentAddedState implements AppStates {}

