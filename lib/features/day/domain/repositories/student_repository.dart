import 'package:my_students/features/day/domain/entities/student.dart';

import '../../data/model/student_model.dart';

abstract class StudentRepository {
  const StudentRepository();

  Future<List<Student>> getStudents({bool? isAlpha = false});
  Future<List<Student>> searchStudents(String name);

  Future<void> addStudent(StudentModel studentMode);

  Future<void> updateStudent(StudentModel studentModel);
  Future<void> updateGrade(StudentModel studentModel);
  Future<void> updatestars(StudentModel studentModel);

  Future<void> resetGrades();
  Future<void> deleteStudents();
  Future<void> deleteOneStudent(int id);
}
