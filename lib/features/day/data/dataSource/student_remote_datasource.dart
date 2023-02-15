import 'package:my_students/features/day/data/model/student_model.dart';

abstract class StudentRemoteDataSource {
  const StudentRemoteDataSource();

  Future<List<StudentModel>> getStudents({bool? isAlpha = false});
  Future<List<StudentModel>> searchStudents(String name);

  Future<void> addStudent(StudentModel studentMode);

  Future<void> updateStudent(StudentModel studentModel);
  Future<void> updateGrade(StudentModel studentModel);
  Future<void> updatestars(StudentModel studentModel);

  Future<void> resetGrades();
  Future<void> deleteStudents();
  Future<void> deleteOneStudent(int id);
}
