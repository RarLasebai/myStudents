import 'package:my_students/features/day/domain/entities/fields.dart';
import 'package:my_students/features/day/domain/entities/student.dart';

class StudentModel extends Student {
  StudentModel(
      {String? studentName,
      String? studentNote,
      int? studentId,
      int? studentStars,
      double? studentGrade,
      double? studentTotalGrades})
      : super(
            studentId: studentId,
            studentName: studentName,
            studentGrade: studentGrade,
            studentNote: studentNote,
            studentStars: studentStars,
            studentTotalGrades: studentTotalGrades);

  StudentModel copy(
          {int? studentId,
          String? studentName,
          double? studentGrade,
          String? studentNote,
          double? studentTotoalGrades,
          int? studentStars}) =>
      StudentModel(
          studentId: studentId ?? this.studentId,
          studentName: studentName ?? this.studentName,
          studentGrade: studentGrade ?? this.studentGrade,
          studentNote: studentNote ?? this.studentNote,
          studentTotalGrades: studentTotoalGrades ?? studentTotalGrades,
          studentStars: studentStars ?? this.studentStars);

  StudentModel.fromJson(Map<String, dynamic> json)
      : super(
          studentGrade: json[StudentsFields.studentGrade] as double,
          studentId: json[StudentsFields.id] as int,
          studentName: json[StudentsFields.studentName] as String,
          studentNote: json[StudentsFields.studentNote] as String,
          studentStars: json[StudentsFields.stars] as int,
          studentTotalGrades: json[StudentsFields.studetnWeekGrade] as double,
        );

  Map<String, dynamic> toJson() => {
        StudentsFields.id: studentId,
        StudentsFields.studentName: studentName,
        StudentsFields.studentGrade: studentGrade,
        StudentsFields.studentNote: studentNote,
        StudentsFields.studetnWeekGrade: studentTotalGrades,
        StudentsFields.stars: studentStars,
      };
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['student_grade'] = studentGrade;
  //   data['student_id'] = studentId;
  //   data['student_name'] = studentName;
  //   data['student_note'] = studentNote;
  //   data['student_stars'] = studentStars;
  //   data['student_total_grades'] = studentTotalGrades;

  //   return data;
  // }
}


//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     return data;
//   }
// }
