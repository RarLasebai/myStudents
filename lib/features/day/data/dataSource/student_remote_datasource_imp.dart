import 'package:my_students/features/day/data/dataSource/student_remote_datasource.dart';
import 'package:my_students/features/day/data/model/student_model.dart';

import '../../domain/entities/fields.dart';
import 'mystudents_database.dart';

class StudentRemoteDataSourceImp extends StudentRemoteDataSource {
  
  //get
  @override
  Future<List<StudentModel>> getStudents({bool? isAlpha = false}) async {
    final db = await MYStudentsDatabase.instance.database;
    if (isAlpha == true) {
      final result = await db.rawQuery('''
  SELECT * FROM $studentTable ORDER BY "${StudentsFields.studentName}" ASC   
''');
      return result.map((json) => StudentModel.fromJson(json)).toList();
    } else {
      final result = await db.rawQuery('''
  SELECT * FROM $studentTable ORDER BY "${StudentsFields.studentGrade}" DESC   
''');
      return result.map((json) => StudentModel.fromJson(json)).toList();
    }
  }

  @override
  Future<List<StudentModel>> searchStudents(String name) async {
    final db = await MYStudentsDatabase.instance.database;
    try {
      final result = await db.rawQuery('''
  SELECT * FROM $studentTable where ${StudentsFields.studentName} = $name ORDER BY "${StudentsFields.studentGrade}" DESC   
''');

      return result.map((json) => StudentModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//add
  @override
  Future<StudentModel> addStudent(StudentModel studentMode) async {
    final db = await MYStudentsDatabase.instance.database;
    final id = await db.rawInsert('''insert into students 
        ( ${StudentsFields.studentName}, ${StudentsFields.studentGrade},${StudentsFields.studetnWeekGrade}, ${StudentsFields.studentNote}, ${StudentsFields.stars}) 
        values ( "${studentMode.studentName}", ${studentMode.studentGrade}, ${studentMode.studentTotalGrades}, "${studentMode.studentNote}", 0)''');
    //  await db.insert(studentTable, studentModel.toJson());
    getStudents();
    return studentMode.copy(
      studentId: id,
    );
  }

//update
  @override
  Future<void> updateStudent(StudentModel studentModel) async {
    final db = await MYStudentsDatabase.instance.database;
    if (studentModel.studentNote == " ") {
      studentModel.studentNote = "لا توجد ملاحظات";
    }
    try {
      await db.rawUpdate('''
 update $studentTable set 
 ${StudentsFields.studentName} = ?, ${StudentsFields.studentNote} = ?
 where ${StudentsFields.id} == ? ''', [
        "${studentModel.studentName}",
        "${studentModel.studentNote}",
        studentModel.studentId
      ]);
      getStudents();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateGrade(StudentModel studentModel) async {
    final db = await MYStudentsDatabase.instance.database;

    try {
      await db.rawUpdate('''
 update $studentTable set 
 ${StudentsFields.studentGrade} = ?,
  ${StudentsFields.studetnWeekGrade} = ? + ? 
 where ${StudentsFields.id} == ? ''', [
        studentModel.studentGrade,
        studentModel.studentTotalGrades,
        studentModel.studentGrade,
        studentModel.studentId
      ]);
      getStudents();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updatestars(StudentModel studentModel) async {
    final db = await MYStudentsDatabase.instance.database;

    try {
      await db.rawUpdate('''
 update $studentTable set 
 ${StudentsFields.stars} = ?
 where ${StudentsFields.id} == ? ''',
          [studentModel.studentStars, studentModel.studentId]);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//delete
  @override
  Future<void> resetGrades() async {
    final db = await MYStudentsDatabase.instance.database;

    try {
      await db.rawUpdate('''
 update $studentTable set 
 ${StudentsFields.studentGrade} = 0,
  ${StudentsFields.studetnWeekGrade} = 0,  ${StudentsFields.stars} = 0 
''');
      getStudents();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteStudents() async {
    final db = await MYStudentsDatabase.instance.database;

    try {
      db.rawDelete("delete from $studentTable");
      getStudents();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteOneStudent(int id) async {
    final db = await MYStudentsDatabase.instance.database;

    try {
      db.rawDelete(
          "delete from $studentTable where ${StudentsFields.id} = $id");
      getStudents(isAlpha: false);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
