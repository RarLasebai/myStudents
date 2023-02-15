// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_students/core/utils/colors/colors.dart';
import 'package:my_students/core/utils/widgets/txt_style.dart';
import 'package:my_students/features/day/application/student_bloc/student_cubit.dart';
import 'package:my_students/features/day/data/model/student_model.dart';
import 'package:my_students/features/day/presentation/screens/update_student_screen.dart';
import 'package:my_students/features/day/presentation/widgets/add_grade_popup.dart';

class DailyStudentGradeWidget extends StatelessWidget {
  final StudentModel studentModel;
  final StudentCubit cubit;

  const DailyStudentGradeWidget({
    super.key,
    required this.cubit,
    required this.studentModel,
  });

  @override
  Widget build(BuildContext context) {
    //colors for grade logic
    Color color;
    String rate = "التقدير";
    double gradeToInt = studentModel.studentGrade!;
    if (50 >= gradeToInt && gradeToInt >= 0) {
      color = Colors.red;
      rate = "ضعيف";
    } else if (65 >= gradeToInt && gradeToInt >= 51) {
      color = Color.fromARGB(255, 171, 176, 19);
      rate = "جيد";
    } else if (75 >= gradeToInt && gradeToInt >= 66) {
      color = Color.fromARGB(255, 7, 83, 145);
      rate = "جيدجداً";
    } else if (100 >= gradeToInt && gradeToInt >= 76) {
      color = Colors.green;
      rate = "ممتاز";
    } else {
      color = Colors.black;
    }

    return BlocProvider.value(
      value: cubit,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 13.0),
          child: Container(
            // height: 240.h,
            // width: 332.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: primary,
              ),
              borderRadius: BorderRadius.circular(30.0.r),
            ),
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 25,
              top: 14,
              bottom: 11,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TxtStyle(
                              "الاسم", 12, darkGrey, FontWeight.bold),
                          TxtStyle(studentModel.studentName!, 14, Colors.black,
                              FontWeight.bold),
                          const TxtStyle(
                              "الدرجة", 12, darkGrey, FontWeight.bold),
                          Row(
                            children: [
                              TxtStyle("${studentModel.studentGrade!}", 14,
                                  color, FontWeight.bold),
                              SizedBox(
                                width: 33.w,
                              ),
                              TxtStyle(rate, 14, color, FontWeight.bold),
                            ],
                          ),
                          const TxtStyle(
                              "ملاحظة", 12, darkGrey, FontWeight.bold),
                          TxtStyle(
                              studentModel.studentNote!.isEmpty
                                  ? "لا توجد ملاحظات"
                                  : studentModel.studentNote!,
                              14,
                              Colors.black,
                              FontWeight.bold),
                        ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return BlocProvider.value(
                                        value: cubit,
                                        child: AddGradePopup(
                                          studentModel: studentModel,
                                        ));
                                  });
                            },
                            child: Image.asset("assets/add_grade.png")),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                              value: cubit,
                                              child: UpdateStudentScreen(
                                                studentModel: StudentModel(
                                                    studentId:
                                                        studentModel.studentId,
                                                    studentGrade: studentModel
                                                        .studentGrade,
                                                    studentName: studentModel
                                                        .studentName,
                                                    studentNote: studentModel
                                                        .studentNote,
                                                    studentStars: studentModel
                                                        .studentStars,
                                                    studentTotalGrades:
                                                        studentModel
                                                            .studentTotalGrades),
                                              ),
                                            )));
                              },
                              child: Image.asset("assets/edit.png")),
                        ),
                        SizedBox(height: 70.h)
                      ],
                    )
                  ],
                ),
                RatingBar.builder(
                  initialRating: studentModel.studentStars!.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star_rate_rounded,
                    color: Colors.yellow,
                  ),
                  onRatingUpdate: (rating) {
                    studentModel.studentStars = rating.toInt();
                    cubit.updateStars(studentModel);
                    print(rating);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
