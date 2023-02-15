import 'package:my_students/features/day/data/dataSource/student_remote_datasource_imp.dart';
import 'package:my_students/features/day/domain/entities/student.dart';
import 'package:my_students/features/day/domain/repositories/student_repository.dart';

import '../model/student_model.dart';

class StudentRepositoryImp implements StudentRepository {
  StudentRemoteDataSourceImp studentRemoteDataSource =
      StudentRemoteDataSourceImp();

//get
  @override
  Future<List<Student>> getStudents({bool? isAlpha = false}) async {
    return await studentRemoteDataSource.getStudents();
  }

  @override
  Future<List<Student>> searchStudents(String name) async {
    return await studentRemoteDataSource.searchStudents(name);
  }

//add
  @override
  Future<void> addStudent(StudentModel studentMode) async {
    await studentRemoteDataSource.addStudent(studentMode);
  }

//updates
  @override
  Future<void> updateStudent(StudentModel studentModel) async {
    await studentRemoteDataSource.updateStudent(studentModel);
  }

  @override
  Future<void> updateGrade(StudentModel studentModel) async {
    await studentRemoteDataSource.updateGrade(studentModel);
  }

  @override
  Future<void> updatestars(StudentModel studentModel) async {
    return await studentRemoteDataSource.updatestars(studentModel);
  }

//delete
  @override
  Future<void> resetGrades() async {
    await studentRemoteDataSource.resetGrades();
  }

  @override
  Future<void> deleteStudents() async {
    await studentRemoteDataSource.deleteStudents();
  }

  @override
  Future<void> deleteOneStudent(int id) async {
    await studentRemoteDataSource.deleteOneStudent(id);
  }
}
