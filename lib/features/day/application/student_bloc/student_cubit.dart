// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_students/features/day/application/student_bloc/student_states.dart';
import 'package:my_students/features/day/data/dataSource/student_remote_datasource_imp.dart';
import 'package:my_students/features/day/data/model/student_model.dart';
import 'package:my_students/features/day/domain/entities/student.dart';

class StudentCubit extends Cubit<StudentStates> {
  StudentCubit() : super(InitStudentState());

  //variables
  static StudentCubit get(context) => BlocProvider.of(context);
  StudentRemoteDataSourceImp studentRemoteDataSourceImp =
      StudentRemoteDataSourceImp();
  List<Student>? filterdStudents;
//controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController gradeController = TextEditingController();

  //keys
  GlobalKey<FormState> formKeyNewStudent = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyAddGrade = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyUpdateStudent = GlobalKey<FormState>();

//Functions

//add
  Future addStudent(StudentModel studentModel) async {
    try {
      emit(LoadingStudentState());

      await studentRemoteDataSourceImp.addStudent(studentModel);
      emit(StudentAddedState());
    } catch (e) {
      print(e.toString());
      emit(ErrorStudentState(e.toString()));
    }
  }

  void addToFilter(Student student) {
    filterdStudents!.add(student);
    emit(GetFilterListState(filterdStudents!));
  }

//get
  Future getStudents({bool? isAlpha = false}) async {
    try {
      emit(LoadingStudentState());
      List<Student> students =
          await studentRemoteDataSourceImp.getStudents(isAlpha: isAlpha);

      emit(StudentsLoadedState(students));
    } catch (e) {
      print(e.toString());
      emit(ErrorStudentState(e.toString()));
    }
  }

  //update
  Future updateStudent(StudentModel studentModel) async {
    try {
      emit(StudentUpdateState());
      if (nameController.text.isEmpty) {
        studentModel.studentName = studentModel.studentName;
      } else {
        studentModel.studentName = nameController.text;
      }

      if (noteController.text.isEmpty) {
        studentModel.studentNote = studentModel.studentNote;
      } else {
        studentModel.studentNote = noteController.text;
      }
      await studentRemoteDataSourceImp.updateStudent(studentModel);
      emit(StudentUpdatedState());
      nameController.clear();
      noteController.clear();
    } catch (e) {
      print(e.toString());
      emit(ErrorStudentState(e.toString()));
    }
  }

  Future updateStars(StudentModel studentModel) async {
    try {
      // emit(UpdateStarsLoadingState());

      await studentRemoteDataSourceImp.updatestars(studentModel);
      // emit(UpdateStarsLoadedState());
    } catch (e) {
      print(e.toString());
      emit(ErrorStudentState(e.toString()));
    }
  }

  Future updateGrade(StudentModel studentModel) async {
    try {
      emit(UpdateGradeLoadingState());

      studentModel.studentGrade = double.parse(gradeController.text.toString());

      await studentRemoteDataSourceImp.updateGrade(studentModel);
      emit(UpdateGradeLoadedState());
      gradeController.clear();
    } catch (e) {
      print(e.toString());
      emit(ErrorStudentState(e.toString()));
    }
  }

//delete
  Future resetGrades() async {
    try {
      emit(ResetGradesLoadingState());

      await studentRemoteDataSourceImp.resetGrades();
      emit(ResetGradesLoadedState());
    } catch (e) {
      print(e.toString());
      emit(ErrorStudentState(e.toString()));
    }
  }

  Future deleteStudents() async {
    try {
      emit(DeleteStudentsLoadingState());

      await studentRemoteDataSourceImp.deleteStudents();
      emit(DeleteStudentsLoadedState());
    } catch (e) {
      print(e.toString());
      emit(ErrorStudentState(e.toString()));
    }
  }

  Future deleteOneStudent(int id) async {
    try {
      emit(DeleteOneStudentLoadingState());

      await studentRemoteDataSourceImp.deleteOneStudent(id);
      emit(DeleteOneStudentLoadedState());
    } catch (e) {
      print(e.toString());
      emit(ErrorStudentState(e.toString()));
    }
  }
}
