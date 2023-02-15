import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_students/core/utils/widgets/loading_widget.dart';
import 'package:my_students/features/day/application/student_bloc/student_states.dart';
import 'package:my_students/features/day/presentation/widgets/start_of_the_day_popup.dart';

import 'package:my_students/features/week/presentation/widgets/weekly_student_grade_widget.dart';

import '../../../../core/utils/widgets/txt_style.dart';
import '../../../day/application/student_bloc/student_cubit.dart';

class WeekScreen extends StatelessWidget {
  const WeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: BlocProvider.value(
        value: BlocProvider.of<StudentCubit>(context)..getStudents(),
        child: BlocConsumer<StudentCubit, StudentStates>(
            listener: (context, studentState) {
          if (studentState is ErrorStudentState) {
            Center(
              child: TxtStyle(studentState.message.toString(), 16, Colors.black,
                  FontWeight.bold),
            );
          }
        }, builder: (context, studentState) {
          if (studentState is StudentsLoadedState) {
            if (studentState.students.isEmpty) {
              return const Center(
                  child: TxtStyle("لا يوجد طلبة مسجلين بعد!", 16, Colors.grey,
                      FontWeight.w500,
                      textAlignm: TextAlign.center));
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    ...studentState.students.map((student) => GestureDetector(
                          onTap: (() => showDialog(
                              context: context,
                              builder: (context) => StarOfTheDayPopup(
                                  name: student.studentName!))),
                          child: WeeklyStudentGradeWidget(
                            grade: student.studentTotalGrades.toString(),
                            name: student.studentName,
                            stars: student.studentStars.toString(),
                          ),
                        ))
                  ],
                ),
              );
            }
          } else {
            return const LoadingWidget();
          }
        }),
      ),
    );
  }
}
